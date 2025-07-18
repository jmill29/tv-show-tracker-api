package com.jmill29.tvtrackerapi.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

import com.jmill29.tvtrackerapi.model.Show;

public interface ShowDao {

    /**
     * Finds a show by its unique ID.
     *
     * <p>
     * This method queries the database for a show with the specified unique identifier.
     * </p>
     *
     * @param id the ID of the show
     * @return an {@code Optional} containing the {@code Show} if found, or empty if not found
     * @throws SQLException if a database access error occurs
     */
    Optional<Show> findById(int id) throws SQLException;

    /**
     * Retrieves all shows from the database.
     *
     * <p>
     * Returns a complete list of all shows stored in the system.
     * </p>
     *
     * @return a {@code List} of all {@code Show} records
     * @throws SQLException if a database access error occurs
     */
    List<Show> findAll() throws SQLException;

    /**
     * Finds shows by their name (case-insensitive, partial match).
     *
     * <p>
     * This method performs a partial match search that may return multiple results containing the given name,
     * using case-insensitive comparison.
     * </p>
     *
     * @param name the name or substring of the show to search for
     * @return a {@code List} of {@code Show} objects with names containing the given substring
     * @throws SQLException if a database access error occurs
     */
    List<Show> findByName(String name) throws SQLException;

    /**
     * Finds shows by their genre (exact match).
     *
     * <p>
     * Returns all shows that belong to the specified genre using an exact match search.
     * </p>
     *
     * @param genre the genre to search for (must match exactly)
     * @return a {@code List} of {@code Show} objects in the specified genre
     * @throws SQLException if a database access error occurs
     */
    List<Show> findByGenre(String genre) throws SQLException;

    /**
     * Saves a {@code Show} to the database.
     *
     * <p>
     * If the {@code showId} of the given {@code show} is 0, it is treated as a new show
     * and will be inserted into the database.  
     * If the {@code showId} is non-zero, it is assumed the show already exists and an update
     * operation will be performed instead.
     * </p>
     *
     * @param show the {@code Show} object to insert or update
     * @return {@code true} if the operation was successful, {@code false} otherwise
     * @throws SQLException if a database access error occurs
     */
    boolean save(Show show) throws SQLException;

    /**
     * Deletes a show by its unique ID.
     *
     * <p>
     * Attempts to remove the show with the specified ID from the database.
     * </p>
     *
     * @param id the ID of the show to delete
     * @return {@code true} if the show was deleted successfully, {@code false} otherwise
     * @throws SQLException if a database access error occurs
     */
    boolean deleteById(int id) throws SQLException;
}
