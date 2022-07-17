const mongoose = require('mongoose');

const noteSchema = mongoose.Schema({
    id: {
        type: String,
        unique: true,
        required: true
    },
    userid: {
        type: String,
        required: true,
    },
    title: {
        type: String,
        required: true,
    },
    content: {
        type: String,
    },
    dateadded: {
        type: Date,
        default: Date.now,
    }
});

module.exports = mongoose.model("Note", noteSchema);