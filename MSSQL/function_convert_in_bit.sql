USE [db]
GO

/*
 * An handler to conver a number in bit an show the result in a table
 */

CREATE FUNCTION [dbo].[function_convert_in_bit] (
	@code int
)
RETURNS @table TABLE (
		b bit,
		i int
	)
AS
BEGIN
	DECLARE @index int = 0

	WHILE @code > 0
	BEGIN
		INSERT INTO @table ( b, i )
		VALUES ( @code  % 2, @index )

		SET @code = @code / 2
		SET @index = @index + 1
	END

	RETURN
END
GO

SELECT *
FROM [dbo].[function_convert_in_bit] ( 49280 ) AS tmp
GO

/*
 * Convert a number in its binary value (ChatGPT solution)
 *
 */

CREATE FUNCTION dbo.[int_to_binary_string](@intValue INT)
RETURNS VARCHAR(32)
AS
BEGIN
    DECLARE @binaryString VARCHAR(32) = ''
    DECLARE @bit INT
    DECLARE @value INT = @intValue

    WHILE @value > 0
    BEGIN
        SET @bit = @value % 2
        SET @binaryString = CAST(@bit AS VARCHAR(1)) + @binaryString
        SET @value = @value / 2
    END

    RETURN @binaryString
END
GO
	
SELECT dbo.IntToBinaryString(49280)
