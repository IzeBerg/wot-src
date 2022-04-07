package net.wg.gui.lobby.techtree.data.vo
{
   import net.wg.gui.lobby.techtree.interfaces.IValueObject;
   import net.wg.utils.ILocale;
   
   public class UnlockProps implements IValueObject
   {
      
      private static const MIN_SOURCE_ARRAY_LEN:uint = 4;
      
      private static const SOURCE_ARRAY_PARENT_ID_INDEX:uint = 0;
      
      private static const SOURCE_ARRAY_UNLOCK_IDX_INDEX:uint = 1;
      
      private static const SOURCE_ARRAY_XP_COST_INDEX:uint = 2;
      
      private static const SOURCE_ARRAY_REQUIRED_DATA_INDEX:uint = 3;
       
      
      private var _parentID:Number;
      
      private var _unlockIdx:Number;
      
      private var _xpCost:Number;
      
      private var _required:Array;
      
      private var _disposed:Boolean = false;
      
      public function UnlockProps(param1:Number = 0, param2:Number = -1, param3:Number = 0, param4:Array = null)
      {
         super();
         this._parentID = param1;
         this._unlockIdx = param2;
         this._xpCost = param3;
         this._required = param4 != null ? param4 : [];
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         if(this._required != null)
         {
            this._required.splice(0,this._required.length);
            this._required = null;
         }
      }
      
      public function fromArray(param1:Array, param2:ILocale) : void
      {
         if(param1.length >= MIN_SOURCE_ARRAY_LEN)
         {
            this._parentID = !!isNaN(param1[SOURCE_ARRAY_PARENT_ID_INDEX]) ? Number(0) : Number(param1[SOURCE_ARRAY_PARENT_ID_INDEX]);
            this._unlockIdx = !!isNaN(param1[SOURCE_ARRAY_UNLOCK_IDX_INDEX]) ? Number(0) : Number(param1[SOURCE_ARRAY_UNLOCK_IDX_INDEX]);
            this._xpCost = !!isNaN(param1[SOURCE_ARRAY_XP_COST_INDEX]) ? Number(0) : Number(param1[SOURCE_ARRAY_XP_COST_INDEX]);
            this._required = param1[SOURCE_ARRAY_REQUIRED_DATA_INDEX];
         }
      }
      
      public function fromObject(param1:Object, param2:ILocale) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(!isNaN(param1.parentID))
         {
            this._parentID = param1.parentID;
         }
         if(!isNaN(param1.unlockIdx))
         {
            this._unlockIdx = param1.unlockIdx;
         }
         if(!isNaN(param1.xpCost))
         {
            this._xpCost = param1.xpCost;
         }
         if(param1.required != null)
         {
            this._required = param1.required;
         }
      }
      
      public function hasID(param1:Number) : Boolean
      {
         return this._required != null && this._required.indexOf(param1) > -1;
      }
      
      public function toString() : String
      {
         return "[UnlockProps: parentID = " + this._parentID + ", unlockIdx = " + this.unlockIdx + ", xpCost = " + this._xpCost + ", required = " + this._required + "]";
      }
      
      public function get parentID() : Number
      {
         return this._parentID;
      }
      
      public function get unlockIdx() : Number
      {
         return this._unlockIdx;
      }
      
      public function get xpCost() : Number
      {
         return this._xpCost;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
