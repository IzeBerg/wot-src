package net.wg.gui.components.tooltips.inblocks.blocks
{
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.advanced.DashLine;
   import net.wg.gui.components.advanced.InviteIndicator;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.tooltips.inblocks.data.DashLineItemPriceBlockVO;
   
   public class DashLineItemPriceBlock extends AbstractTextParameterBlock
   {
      
      private static const VALUE_TO_IMAGE_GAP:int = 2;
      
      private static const TF_GAP:int = 3;
      
      private static const INDICATOR_GAP:int = 9;
       
      
      public var nameTF:TextField = null;
      
      public var dashLine:DashLine = null;
      
      public var image:Image = null;
      
      public var inviteIndicator:InviteIndicator = null;
      
      private var _isDataApplied:Boolean = false;
      
      private var _blockWidth:int = -1;
      
      public function DashLineItemPriceBlock()
      {
         super();
         this.nameTF.autoSize = TextFieldAutoSize.LEFT;
         valueTF.autoSize = TextFieldAutoSize.RIGHT;
         this.image.addEventListener(Event.CHANGE,this.onImageChangeHandler);
      }
      
      override public function cleanUp() : void
      {
         clearData();
         this.nameTF.x = this.nameTF.y = valueTF.x = valueTF.y = this.image.x = 0;
         this.inviteIndicator.x = 0;
         this.inviteIndicator.visible = false;
         this.nameTF.text = valueTF.text = null;
         this.dashLine.width = 0;
      }
      
      override public function setBlockData(param1:Object) : void
      {
         this._isDataApplied = false;
         super.setBlockData(param1);
      }
      
      override public function setBlockWidth(param1:int) : void
      {
         this._blockWidth = param1;
      }
      
      override protected function getDataClass() : Class
      {
         return DashLineItemPriceBlockVO;
      }
      
      override protected function onDispose() : void
      {
         this.dashLine.dispose();
         this.dashLine = null;
         this.inviteIndicator.dispose();
         this.inviteIndicator = null;
         this.image.removeEventListener(Event.CHANGE,this.onImageChangeHandler);
         this.image.dispose();
         this.image = null;
         this.nameTF = null;
         super.onDispose();
      }
      
      override protected function onValidateBlock() : Boolean
      {
         if(!this._isDataApplied)
         {
            this.applyData();
            this.invalidateSize();
            return true;
         }
         return false;
      }
      
      private function invalidateSize() : void
      {
         this.image.x = this._blockWidth - this.image.width;
         this.dashLine.x = 0;
         this.dashLine.y = this.nameTF.textHeight - TF_GAP;
         this.dashLine.width = this._blockWidth;
         this.inviteIndicator.visible = !_data.value;
         if(_data.value)
         {
            valueTF.x = this.image.x - VALUE_TO_IMAGE_GAP - valueTF.width;
         }
         else
         {
            this.inviteIndicator.x = this.image.x - this.inviteIndicator.width + INDICATOR_GAP;
         }
      }
      
      private function applyData() : void
      {
         var _loc1_:DashLineItemPriceBlockVO = null;
         this.applyTextData(this.nameTF,_data.name);
         this.applyTextData(valueTF,_data.value);
         _loc1_ = DashLineItemPriceBlockVO(_data);
         var _loc2_:String = _loc1_.icon;
         this.image.source = _loc2_;
         this._isDataApplied = true;
      }
      
      private function applyTextData(param1:TextField, param2:String) : void
      {
         param1.htmlText = param2;
         App.utils.commons.updateTextFieldSize(param1,true,false);
      }
      
      private function onImageChangeHandler(param1:Event) : void
      {
         this.invalidateSize();
      }
   }
}
