require("dotenv").config();

const mongoose = require("mongoose");
const initData = require("./data.js");
const Listing = require("../models/listing.js");

const dbUrl = process.env.ATLASDB_URL;

async function main() {
    try {
        // Connect to MongoDB Atlas
        await mongoose.connect(dbUrl);
        console.log("Connected to MongoDB Atlas");

        // Delete existing listings
        await Listing.deleteMany({});
        console.log("Old listings deleted");

        // Add owner to every listing
        const listingsWithOwner = initData.data.map((obj) => ({
            ...obj,
            Owner: "69e4b14ae472e4781d349841",
        }));

        // Insert sample listings
        await Listing.insertMany(listingsWithOwner);

        console.log("Database initialized with sample data.");

        // Close database connection
        await mongoose.connection.close();
        console.log("Database connection closed.");

    } catch (err) {
        console.log("Error:", err);
    }
}

main();