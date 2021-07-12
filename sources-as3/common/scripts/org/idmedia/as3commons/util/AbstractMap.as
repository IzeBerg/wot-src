package org.idmedia.as3commons.util
{
   import org.idmedia.as3commons.lang.UnsupportedOperationException;
   
   public class AbstractMap implements Map
   {
       
      
      private var v:Collection = null;
      
      private var k:Set = null;
      
      public function AbstractMap()
      {
         super();
      }
      
      public function put(param1:*, param2:*) : *
      {
         throw new UnsupportedOperationException();
      }
      
      public function get(param1:*) : *
      {
         var _loc4_:Entry = null;
         if(param1 === undefined)
         {
            return null;
         }
         var _loc2_:* = param1;
         var _loc3_:Iterator = this.entrySet().iterator();
         while(_loc3_.hasNext())
         {
            _loc4_ = _loc3_.next() as Entry;
            if(_loc2_ === _loc4_.getKey())
            {
               return _loc4_.getValue();
            }
         }
         return null;
      }
      
      public function containsKey(param1:*) : Boolean
      {
         var _loc4_:Entry = null;
         var _loc2_:* = param1 || null;
         var _loc3_:Iterator = this.entrySet().iterator();
         while(_loc3_.hasNext())
         {
            _loc4_ = _loc3_.next() as Entry;
            if(_loc2_ === _loc4_.getKey())
            {
               return true;
            }
         }
         return false;
      }
      
      public function containsValue(param1:*) : Boolean
      {
         var _loc4_:Entry = null;
         var _loc2_:* = param1 || null;
         var _loc3_:Iterator = this.entrySet().iterator();
         while(_loc3_.hasNext())
         {
            _loc4_ = _loc3_.next() as Entry;
            if(_loc2_ === _loc4_.getValue())
            {
               return true;
            }
         }
         return false;
      }
      
      public function remove(param1:*) : *
      {
         var _loc6_:Entry = null;
         var _loc2_:* = param1 || null;
         var _loc3_:Iterator = this.entrySet().iterator();
         var _loc4_:Entry = null;
         while(_loc4_ == null && _loc3_.hasNext())
         {
            _loc6_ = Entry(_loc3_.next());
            if(param1 === _loc6_.getKey())
            {
               _loc4_ = _loc6_;
            }
         }
         var _loc5_:* = null;
         if(_loc4_ != null)
         {
            _loc5_ = _loc4_.getValue();
            _loc3_.remove();
         }
         return _loc5_;
      }
      
      public function clear() : void
      {
         this.entrySet().clear();
      }
      
      public function size() : int
      {
         return this.entrySet().size();
      }
      
      public function values() : Collection
      {
         if(this.v == null)
         {
            this.v = new CollectionImpl(this);
         }
         return this.v;
      }
      
      public function keySet() : Set
      {
         if(this.k == null)
         {
            this.k = new AbstractEntrySet(this);
         }
         return this.k;
      }
      
      public function entrySet() : Set
      {
         throw new UnsupportedOperationException();
      }
      
      public function isEmpty() : Boolean
      {
         return this.size() == 0;
      }
      
      public function putAll(param1:Map) : void
      {
         var _loc3_:Entry = null;
         var _loc2_:Iterator = param1.entrySet().iterator();
         while(_loc2_.hasNext())
         {
            _loc3_ = _loc2_.next() as Entry;
            this.put(_loc3_.getKey(),_loc3_.getValue());
         }
      }
      
      public function equals(param1:*) : Boolean
      {
         return param1 === this;
      }
   }
}

import org.idmedia.as3commons.util.AbstractSet;
import org.idmedia.as3commons.util.Iterator;
import org.idmedia.as3commons.util.Map;

class AbstractEntrySet extends AbstractSet
{
    
   
   private var m:Map = null;
   
   function AbstractEntrySet(param1:Map)
   {
      super();
      this.m = param1;
   }
   
   override public function iterator() : Iterator
   {
      return new KeyIterator(this.m.entrySet().iterator());
   }
   
   override public function size() : int
   {
      return this.m.size();
   }
   
   override public function contains(param1:*) : Boolean
   {
      return this.m.containsKey(param1);
   }
}

import org.idmedia.as3commons.util.AbstractCollection;
import org.idmedia.as3commons.util.Iterator;
import org.idmedia.as3commons.util.Map;

final class CollectionImpl extends AbstractCollection
{
    
   
   private var map:Map;
   
   function CollectionImpl(param1:Map)
   {
      super();
      this.map = param1;
   }
   
   override public function iterator() : Iterator
   {
      return new ValueIterator(this.map.entrySet().iterator());
   }
   
   override public function size() : int
   {
      return this.map.size();
   }
}

import org.idmedia.as3commons.util.Entry;
import org.idmedia.as3commons.util.Iterator;

class KeyIterator implements Iterator
{
    
   
   protected var iter:Iterator;
   
   function KeyIterator(param1:Iterator)
   {
      super();
      this.iter = param1;
   }
   
   public function hasNext() : Boolean
   {
      return this.iter.hasNext();
   }
   
   public function next() : *
   {
      return Entry(this.iter.next()).getKey();
   }
   
   public function remove() : void
   {
      this.iter.remove();
   }
}

import org.idmedia.as3commons.util.Entry;
import org.idmedia.as3commons.util.Iterator;

final class ValueIterator extends KeyIterator
{
    
   
   function ValueIterator(param1:Iterator)
   {
      super(param1);
   }
   
   override public function next() : *
   {
      return Entry(iter.next()).getValue();
   }
}
