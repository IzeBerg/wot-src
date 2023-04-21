package net.wg.data.VO
{
   import net.wg.data.constants.generated.FITTING_TYPES;
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class SellDialogElementVO implements IDisposable
   {
       
      
      public var itemIDList:Array = null;
      
      public var id:String;
      
      public var isRemovable:Boolean;
      
      public var isModernized:Boolean;
      
      public var isWotPlusEnabled:Boolean;
      
      public var count:Number = 1;
      
      public var toInventory:Boolean;
      
      public var fromInventory:Boolean = false;
      
      public var kind:String = "";
      
      public var type:String;
      
      public var onlyToInventory:Boolean = false;
      
      public var moneyValue:Number;
      
      public var removePrice:Object;
      
      public var removeCurrency:String = "";
      
      public var removeActionPriceVo:ActionPriceVO = null;
      
      public var sellActionPriceVo:ActionPriceVO = null;
      
      public var alertIconDataID:String = "";
      
      private var _disposed:Boolean = false;
      
      public function SellDialogElementVO()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         if(this.itemIDList != null)
         {
            this.itemIDList.splice(0,this.itemIDList.length);
            this.itemIDList = null;
         }
         this.removePrice = null;
         this.removeActionPriceVo = null;
         this.sellActionPriceVo = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function get isComplexOptionalDevice() : Boolean
      {
         return this.type == FITTING_TYPES.OPTIONAL_DEVICE && !this.isRemovable;
      }
   }
}
