package org.idmedia.as3commons.util
{
   import org.idmedia.as3commons.lang.IndexOutOfBoundsException;
   import org.idmedia.as3commons.lang.UnsupportedOperationException;
   
   public class AbstractList extends AbstractCollection implements List
   {
       
      
      private var modCount:int = 0;
      
      public function AbstractList()
      {
         super();
      }
      
      override public function add(param1:*) : Boolean
      {
         return this.addAt(size(),param1);
      }
      
      public function get(param1:int) : *
      {
         return null;
      }
      
      public function addAt(param1:int, param2:*) : Boolean
      {
         throw new UnsupportedOperationException();
      }
      
      public function setAt(param1:int, param2:*) : Boolean
      {
         throw new UnsupportedOperationException();
      }
      
      override public function addAll(param1:Collection) : Boolean
      {
         throw new UnsupportedOperationException();
      }
      
      override public function clear() : void
      {
         this.removeRange(0,size());
      }
      
      override public function iterator() : Iterator
      {
         return new ListIteratorImpl(this);
      }
      
      public function listIterator() : ListIterator
      {
         return new ListIteratorImpl(this);
      }
      
      public function indexedListIterator(param1:uint) : ListIterator
      {
         if(param1 < 0 || param1 > size())
         {
            throw new IndexOutOfBoundsException("Index: " + param1);
         }
         var _loc2_:ListIterator = this.listIterator();
         _loc2_.setIndex(param1);
         return _loc2_;
      }
      
      public function removeAt(param1:int) : Boolean
      {
         throw new UnsupportedOperationException();
      }
      
      public function removeAtAndReturn(param1:int) : *
      {
         throw new UnsupportedOperationException();
      }
      
      public function removeAtTo(param1:int, param2:int) : Boolean
      {
         throw new UnsupportedOperationException();
      }
      
      private function removeRange(param1:int, param2:int) : void
      {
         var _loc3_:ListIterator = this.indexedListIterator(param1);
         var _loc4_:int = 0;
         var _loc5_:int = param2 - param1;
         while(_loc4_ < _loc5_)
         {
            _loc3_.next();
            _loc3_.remove();
            _loc4_++;
         }
      }
      
      public function indexOf(param1:* = null) : int
      {
         return toArray().indexOf(param1);
      }
   }
}

import org.idmedia.as3commons.lang.ConcurrentModificationException;
import org.idmedia.as3commons.lang.IllegalStateException;
import org.idmedia.as3commons.lang.IndexOutOfBoundsException;
import org.idmedia.as3commons.lang.NoSuchElementException;
import org.idmedia.as3commons.util.Iterator;
import org.idmedia.as3commons.util.List;

class IteratorImpl implements Iterator
{
    
   
   protected var cursor:int = 0;
   
   protected var lastRet:int = -1;
   
   protected var list:List;
   
   function IteratorImpl(param1:List)
   {
      super();
      this.list = param1;
   }
   
   public function hasNext() : Boolean
   {
      return this.cursor < this.list.size();
   }
   
   public function next() : *
   {
      var nextValue:* = undefined;
      try
      {
         nextValue = this.list.get(this.cursor);
         this.lastRet = this.cursor;
         ++this.cursor;
         return nextValue;
      }
      catch(e:IndexOutOfBoundsException)
      {
         throw new NoSuchElementException();
      }
   }
   
   public function remove() : void
   {
      if(this.lastRet == -1)
      {
         throw new IllegalStateException();
      }
      try
      {
         this.list.removeAt(this.lastRet);
         if(this.lastRet < this.cursor)
         {
            --this.cursor;
         }
         this.lastRet = -1;
      }
      catch(e:IndexOutOfBoundsException)
      {
         throw new ConcurrentModificationException(e.getMessage());
      }
   }
}

import org.idmedia.as3commons.lang.ConcurrentModificationException;
import org.idmedia.as3commons.lang.IllegalStateException;
import org.idmedia.as3commons.lang.IndexOutOfBoundsException;
import org.idmedia.as3commons.lang.NoSuchElementException;
import org.idmedia.as3commons.util.List;
import org.idmedia.as3commons.util.ListIterator;

class ListIteratorImpl extends IteratorImpl implements ListIterator
{
    
   
   function ListIteratorImpl(param1:List)
   {
      super(param1);
   }
   
   public function hasPrevious() : Boolean
   {
      return cursor != 0;
   }
   
   public function previous() : *
   {
      var i:int = 0;
      var previousValue:* = undefined;
      try
      {
         i = cursor - 1;
         previousValue = list.get(i);
         lastRet = cursor = i;
         return previousValue;
      }
      catch(e:IndexOutOfBoundsException)
      {
         throw new NoSuchElementException();
      }
   }
   
   public function nextIndex() : int
   {
      return cursor;
   }
   
   public function previousIndex() : int
   {
      return cursor - 1;
   }
   
   public function setValue(param1:*) : void
   {
      var object:* = param1;
      if(lastRet == -1)
      {
         throw new IllegalStateException();
      }
      try
      {
         list.setAt(lastRet,object);
      }
      catch(e:IndexOutOfBoundsException)
      {
         throw new ConcurrentModificationException();
      }
   }
   
   public function add(param1:*) : void
   {
      var object:* = param1;
      try
      {
         list.addAt(cursor++,object);
         lastRet = -1;
      }
      catch(e:IndexOutOfBoundsException)
      {
         throw new ConcurrentModificationException();
      }
   }
   
   public function setIndex(param1:int) : void
   {
      if(param1 < 0 || param1 >= list.size())
      {
         throw new IndexOutOfBoundsException("Index: " + param1);
      }
      cursor = param1;
   }
}
