module H99.Q1to10
    ( tests1to10,
      encode
    ) where

import           Test.Tasty
import           Test.Tasty.HUnit as HU
--import           Test.HUnit.Tools (assertRaises)

{-| Problem 1.
  Find the last element of a list.
-}
myLast :: [a] -> a
myLast [] = error "No such element"
myLast (x:[]) = x
myLast (_:xs) = myLast xs

problem1 :: TestTree
problem1 = testGroup "Problem 1" [ testCase "myLast [1,2,3,4]" $
                                   myLast [1,2,3,4] @?= 4
                                 , testCase "myLast ['x','y','z']" $
                                   myLast "xyz" @?= 'z'
                                 ]

{-| Problem 2.
  Find the last but one element of a list.
-}
myButLast :: [a] -> a
myButLast [] = error "No such element"
myButLast [x] = error "No such element"
myButLast [x, y] = x
myButLast (x:xs) = myButLast xs

problem2 :: TestTree
problem2 = testGroup "Problem 2" [ testCase "myButLast [1,2,3,4]" $
                                   myButLast [1,2,3,4] @?= 3
                                 , testCase "myButLast ['a'..'z']" $
                                   myButLast ['a'..'z'] @?= 'y'
                                 --, testCase "myButLast []" $
                                 --  assertRaises "should throw" (Exception "No such element") $ evaluate myButLast []
                                 ]

{-| Problem 3.
  Find the K'th element of a list. The first element in the list is number 1.
-}
elementAt :: [a] -> Int -> a
elementAt [] _ = error "No such element"
elementAt (x:xs) 1 = x
elementAt (x:xs) n = elementAt xs (n - 1)

problem3 :: TestTree
problem3 = testGroup "Problem 3" [ testCase "elementAt [1,2,3] 2" $
                                   elementAt [1,2,3] 2 @?= 2
                                 , testCase "elementAt \"haskell\" 5" $
                                   elementAt "haskell" 5 @?= 'e'
                                 ]

{-| Problem 4.
  Find the number of elements of a list.
-}
myLength :: [a] -> Int
myLength [] = 0
myLength (_:xs) = 1 + myLength xs

problem4 :: TestTree
problem4 = testGroup "Problem 4" [ testCase "myLength [123, 456, 789]" $
                                   myLength [123, 456, 789] @?= 3
                                 , testCase "myLength \"Hello, world!\"" $
                                   myLength "Hello, world!" @?= 13
                                 ]

{-| Problem 5.
  Reverse a list.
-}
myReverse :: [a] -> [a]
myReverse [] = []
myReverse (x:xs) = myReverse xs ++ [x]

problem5 :: TestTree
problem5 = testGroup "Problem 5" [ testCase "myReverse \"A man, a plan, a canal, panama!\"" $
                                   myReverse "A man, a plan, a canal, panama!" @?= "!amanap ,lanac a ,nalp a ,nam A"
                                 , testCase "myReverse [1,2,3,4]" $
                                   myReverse [1,2,3,4] @?= [4,3,2,1]
                                 ]

{-| Problem 6.
  Find the number of elements of a list.
-}
isPalindrome :: (Eq a) => [a] -> Bool
isPalindrome xs = xs == myReverse xs

problem6 :: TestTree
problem6 = testGroup "Problem 6" [ testCase "isPalindrome [1,2,3]" $
                                   isPalindrome [1,2,3] @?= False
                                 , testCase "isPalindrome \"madamimadam\"" $
                                   isPalindrome "madamimadam" @?= True
                                 , testCase "isPalindrome [1,2,4,8,16,8,4,2,1]" $
                                   isPalindrome [1,2,4,8,16,8,4,2,1] @?= True
                                 , testCase "isPalindrome []" $
                                   isPalindrome ([] :: [Int]) @?= True
                                 , testCase "isPalindrome [1]" $
                                   isPalindrome [1] @?= True
                                 ]

{-| Problem 7.
  Flatten a nested list structure.
-}
data NestedList a = Elem a | List [NestedList a]
flatten :: NestedList a -> [a]
flatten (Elem x) = [x]
flatten (List xs) = foldl (\accu x -> accu ++ flatten x) [] xs

problem7 :: TestTree
problem7 = testGroup "Problem 7" [ testCase "flatten (Elem 5)" $
                                   flatten (Elem 5) @?= [5]
                                 , testCase "flatten (List [Elem 1, List [Elem 2, List [Elem 3, Elem 4], Elem 5]])" $
                                   flatten (List [Elem 1, List [Elem 2, List [Elem 3, Elem 4], Elem 5]]) @?= [1,2,3,4,5]
                                 , testCase "flatten (List [])" $
                                   flatten (List [] :: NestedList Char) @?= []
                                 ]

{-| Problem 8.
  Eliminate consecutive duplicates of list elements.
-}
compress :: (Eq a) => [a] -> [a]
compress [] = []
compress (x:[]) = [x]
compress (fst:sec:rest)
  | fst == sec = remaining
  | otherwise = fst : remaining
  where remaining = compress $ sec : rest

problem8 :: TestTree
problem8 = testGroup "Problem 8" [ testCase "compress \"aaaabccaadeeee\"" $
                                   compress "aaaabccaadeeee" @?= "abcade"
                                 , testCase "compress [1]" $
                                   compress [1] @?= [1]
                                 , testCase "compress []" $
                                   compress ([] :: [Int]) @?= []
                                 ]

{-| Problem 9.
  Pack consecutive duplicates of list elements into sublists.
  If a list contains repeated elements they should be placed in separate sublists.
-}
pack :: (Eq a) => [a] -> [[a]]
pack xs = foldr grp [[]] xs
  where
    grp e [[]] = [[e]]
    grp e (curList@(h:t):ys)
       | h == e = (e:curList):ys
       | otherwise = [e]:curList:ys

problem9 :: TestTree
problem9 = testGroup "Problem 9" [ testCase "pack ['a', 'a', 'a', 'a', 'b', 'c', 'c', 'a', 'a', 'd', 'e', 'e', 'e', 'e']" $
                                   pack ['a', 'a', 'a', 'a', 'b', 'c', 'c', 'a',
                                         'a', 'd', 'e', 'e', 'e', 'e'] @?= ["aaaa","b","cc","aa","d","eeee"]
                                 , testCase "pack [1]" $
                                   pack [1] @?= [[1]]
                                 , testCase "pack []" $
                                   pack ([] :: [Int]) @?= [[]]
                                 ]

{-| Problem 10.
  Run-length encoding of a list. Use the result of problem P09 to implement the so-called run-length
  encoding data compression method. Consecutive duplicates of elements are encoded
  as lists (N E) where N is the number of duplicates of the element E.
-}
encode :: (Eq a) => [a] -> [(Int, a)]
encode xs = [ (myLength l, h) | l@(h:t) <- pack xs]

problem10 :: TestTree
problem10 = testGroup "Problem 10" [ testCase "encode ['a', 'a', 'a', 'a', 'b', 'c', 'c', 'a', 'a', 'd', 'e', 'e', 'e', 'e']" $
                                   encode ['a', 'a', 'a', 'a', 'b', 'c', 'c', 'a',
                                         'a', 'd', 'e', 'e', 'e', 'e'] @?= [(4,'a'),(1,'b'),(2,'c'),(2,'a'),(1,'d'),(4,'e')]
                                 , testCase "encode [1]" $
                                   encode [1] @?= [(1, 1)]
                                 , testCase "encode []" $
                                   encode ([] :: [Int]) @?= []
                                 ]

tests1to10 :: TestTree
tests1to10 = testGroup "Q1 - 10"
             [ problem1, problem2, problem3, problem4, problem5,
               problem6, problem7, problem8, problem9, problem10 ]
