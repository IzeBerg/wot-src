package net.wg.gui.lobby.tankman.crewSkins
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class CrewSkinStorageInfo extends Sprite implements IDisposable
   {
       
      
      public var tfStorageTitle:TextField;
      
      public var tfStorageAvailableAmount:TextField;
      
      public var tfStorageMaxAmount:TextField;
      
      public var tfUsageTitle:TextField;
      
      public var tfUsageAmount:TextField;
      
      private var _offsetBetweenAvailableAndMaxAmountTFs:Number;
      
      private var _disposed:Boolean = false;
      
      public function CrewSkinStorageInfo()
      {
         super();
         this._offsetBetweenAvailableAndMaxAmountTFs = this.calculateOffsetX(this.tfStorageAvailableAmount,this.tfStorageMaxAmount);
         var _loc1_:Number = this.calculateOffsetX(this.tfStorageTitle,this.tfStorageAvailableAmount);
         this.tfStorageTitle.text = App.utils.locale.makeString(CREW_SKINS.FEATURE_INSTORAGE);
         this.tfStorageTitle.autoSize = TextFieldAutoSize.LEFT;
         this.tfStorageAvailableAmount.x = this.tfStorageTitle.x + this.tfStorageTitle.width + _loc1_;
         _loc1_ = this.calculateOffsetX(this.tfUsageTitle,this.tfUsageAmount);
         this.tfUsageTitle.text = App.utils.locale.makeString(CREW_SKINS.FEATURE_INUSE);
         this.tfUsageTitle.autoSize = TextFieldAutoSize.LEFT;
         this.tfUsageAmount.x = this.tfUsageTitle.x + this.tfUsageTitle.width + _loc1_;
         this.tfStorageAvailableAmount.autoSize = TextFieldAutoSize.LEFT;
         this.tfStorageMaxAmount.autoSize = TextFieldAutoSize.LEFT;
         this.tfUsageAmount.autoSize = TextFieldAutoSize.LEFT;
      }
      
      public function update(param1:int, param2:int, param3:int) : void
      {
         this.tfStorageAvailableAmount.text = String(param1);
         this.tfStorageMaxAmount.text = "(" + param2 + ")";
         this.tfStorageMaxAmount.x = this.tfStorageAvailableAmount.x + this.tfStorageAvailableAmount.width + this._offsetBetweenAvailableAndMaxAmountTFs;
         this.tfUsageAmount.text = String(param3);
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.tfStorageTitle = null;
         this.tfStorageAvailableAmount = null;
         this.tfStorageMaxAmount = null;
         this.tfUsageTitle = null;
         this.tfUsageAmount = null;
      }
      
      private function calculateOffsetX(param1:DisplayObject, param2:DisplayObject) : Number
      {
         return param2.x - param1.x - param1.width;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
