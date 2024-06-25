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

SELECT [dbo].[function_convert_in_bit] ( 49280 )
