package net.wg.data.VO
{
   import net.wg.data.constants.generated.FITTING_TYPES;
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class SellDialogElementVO implements IDisposable
   {
       
      
      private var _itemIDList:Array = null;
      
      private var _id:String;
      
      private var _isRemovable:Boolean;
      
      private var _count:Number = 1;
      
      private var _toInventory:Boolean;
      
      private var _fromInventory:Boolean = false;
      
      private var _kind:String = "";
      
      private var _type:String;
      
      private var _onlyToInventory:Boolean = false;
      
      private var _moneyValue:Number;
      
      private var _removePrice:Object;
      
      private var _removeCurrency:String = "";
      
      private var _removeActionPriceVo:ActionPriceVO = null;
      
      private var _sellActionPriceVo:ActionPriceVO = null;
      
      private var _disposed:Boolean = false;
      
      public function SellDialogElementVO()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         if(this._itemIDList != null)
         {
            this._itemIDList.splice(0,this._itemIDList.length);
            this._itemIDList = null;
         }
         this._removePrice = null;
         this._removeActionPriceVo = null;
         this._sellActionPriceVo = null;
      }
      
      public function get isComplexOptionalDevice() : Boolean
      {
         return this._type == FITTING_TYPES.OPTIONAL_DEVICE && !this._isRemovable;
      }
      
      public function get removePrice() : Object
      {
         return this._removePrice;
      }
      
      public function set removePrice(param1:Object) : void
      {
         this._removePrice = param1;
      }
      
      public function get removeCurrency() : String
      {
         return this._removeCurrency;
      }
      
      public function set removeCurrency(param1:String) : void
      {
         this._removeCurrency = param1;
      }
      
      public function get sellActionPriceVo() : ActionPriceVO
      {
         return this._sellActionPriceVo;
      }
      
      public function set sellActionPriceVo(param1:ActionPriceVO) : void
      {
         this._sellActionPriceVo = param1;
      }
      
      public function get removeActionPriceVo() : ActionPriceVO
      {
         return this._removeActionPriceVo;
      }
      
      public function set removeActionPriceVo(param1:ActionPriceVO) : void
      {
         this._removeActionPriceVo = param1;
      }
      
      public function get moneyValue() : Number
      {
         return this._moneyValue;
      }
      
      public function set moneyValue(param1:Number) : void
      {
         this._moneyValue = param1;
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function set type(param1:String) : void
      {
         this._type = param1;
      }
      
      public function get count() : Number
      {
         return this._count;
      }
      
      public function set count(param1:Number) : void
      {
         this._count = param1;
      }
      
      public function get toInventory() : Boolean
      {
         return this._toInventory;
      }
      
      public function set toInventory(param1:Boolean) : void
      {
         this._toInventory = param1;
      }
      
      public function get fromInventory() : Boolean
      {
         return this._fromInventory;
      }
      
      public function set fromInventory(param1:Boolean) : void
      {
         this._fromInventory = param1;
      }
      
      public function get isRemovable() : Boolean
      {
         return this._isRemovable;
      }
      
      public function set isRemovable(param1:Boolean) : void
      {
         this._isRemovable = param1;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function set id(param1:String) : void
      {
         this._id = param1;
      }
      
      public function get kind() : String
      {
         return this._kind;
      }
      
      public function set kind(param1:String) : void
      {
         this._kind = param1;
      }
      
      public function get itemIDList() : Array
      {
         return this._itemIDList;
      }
      
      public function set itemIDList(param1:Array) : void
      {
         this._itemIDList = param1;
      }
      
      public function get onlyToInventory() : Boolean
      {
         return this._onlyToInventory;
      }
      
      public function set onlyToInventory(param1:Boolean) : void
      {
         this._onlyToInventory = param1;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
