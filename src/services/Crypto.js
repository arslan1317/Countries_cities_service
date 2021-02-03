const _crypto = require('crypto');
const uuidv4 = require('uuid/v4');
const atob = require('atob');
const hkdf = require('futoin-hkdf');

function Crypto() {

    const mediaTypes = {
        IMAGE: 'Image',
        VIDEO: 'Video',
        AUDIO: 'Audio',
        PTT: 'Audio',
        DOCUMENT: 'Document',
        STICKER: 'Image'
    };

    const base64ToBytes = (base64Str) => {
        const binaryStr = atob(base64Str);
        
        const byteArray = new Uint8Array(binaryStr.length);

        for (let i = 0; i < binaryStr.length; i++) {
            byteArray[i] = binaryStr.charCodeAt(i);
        }

        return byteArray;
    };

    const hexToBytes = (hexStr) => {
        const intArray = [];

        for (let i = 0; i < hexStr.length; i += 2) {
            intArray.push(parseInt(hexStr.substr(i, 2), 16));
        }

        return new Uint8Array(intArray);
    };

    this.decodeWhatsappMedia = async function decodeWhatsappMedia(rawBuffer, mediaKey, type) {
        const encodedHex = rawBuffer.toString('hex');
        
        let encodedBytes = hexToBytes(encodedHex);

        let mediaKeyBytes = base64ToBytes(mediaKey);

        const info = `WhatsApp ${mediaTypes[type.toUpperCase()]} Keys`;

        const hash = 'sha256';

        const salt = new Uint8Array(32);

        const expandedSize = 112;

        const mediaKeyExpanded = hkdf(mediaKeyBytes, expandedSize, {
            salt,
            info,
            hash
        });

        const iv = mediaKeyExpanded.slice(0, 16);
        const cipherKey = mediaKeyExpanded.slice(16, 48);
        
        encodedBytes = encodedBytes.slice(0, -10);
        
        const decipher = _crypto.createDecipheriv('aes-256-cbc', cipherKey, iv);

        const decodedBytes = decipher.update(encodedBytes);
        
        const mediaDataBuffer = Buffer.from(decodedBytes, 'utf-8');

        return mediaDataBuffer;
    };

    this.randomString = (str_length) => {
        return _crypto.randomBytes(str_length).toString('hex');
    };

    this.salt = () => {
        return this.randomString(16);
    };

    this.generateApiKey = (host, number, uuid, salt) => {
        const plainText = `${host}:${number}:${uuid}`;

        return _crypto.createHmac('sha256', salt).update(plainText).digest('hex');
    };

    this.generatePasswordHash = (password, salt) => {
        const plainText = `${password}:${salt}`;

        return _crypto.createHmac('sha256', salt).update(plainText).digest('hex');
    };

    this.uuid = () => {
        return uuidv4();
    };

    return this;
};

module.exports = Crypto;