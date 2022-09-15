package net.wg.gui.components.tooltips.inblocks.blocks
{
   import flash.events.Event;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.tooltips.inblocks.data.TitleBlockVO;
   
   public class TitleBlock extends BaseTooltipBlock
   {
      
      private static const STANDARD_ICON_HEIGHT:int = 160;
      
      private static const BLOCK_ALPHA_ENABLED:Number = 1;
      
      private static const BLOCK_ALPHA_DISABLED:Number = 0.7;
       
      
      private var _titleImage:Image = null;
      
      private var _data:TitleBlockVO = null;
      
      private var _isDataApplied:Boolean = false;
      
      private var _blockWidth:Number = 0;
      
      public function TitleBlock()
      {
         super();
         this._titleImage = new Image();
         addChild(this._titleImage);
         this._titleImage.addEventListener(Event.CHANGE,this.onTitleImageChangeHandler);
      }
      
      override public function cleanUp() : void
      {
         super.cleanUp();
         this._blockWidth = 0;
      }
      
      override public function getWidth() : Number
      {
         return this._blockWidth > 0 ? Number(this._blockWidth) : Number(super.getWidth());
      }
      
      override public function setBlockData(param1:Object) : void
      {
         this.clearData();
         this._data = new TitleBlockVO(param1);
         this._isDataApplied = false;
         invalidateBlock();
      }
      
      override public function setBlockWidth(param1:int) : void
      {
         this._blockWidth = param1;
      }
      
      override protected function onValidateBlock() : Boolean
      {
         if(!this._isDataApplied)
         {
            this.applyData();
            return true;
         }
         this.updateLayout();
         return false;
      }
      
      override protected function onDispose() : void
      {
         this.clearData();
         removeChild(this._titleImage);
         this._titleImage.removeEventListener(Event.CHANGE,this.onTitleImageChangeHandler);
         this._titleImage.dispose();
         this._titleImage = null;
         super.onDispose();
      }
      
      private function updateLayout() : void
      {
         this._titleImage.x = this._blockWidth - this._titleImage.width >> 1;
         this._titleImage.y = STANDARD_ICON_HEIGHT - this._titleImage.height >> 1;
      }
      
      private function applyData() : void
      {
         this._titleImage.source = this._data.titleImage;
         alpha = !!this._data.isEnabled ? Number(BLOCK_ALPHA_ENABLED) : Number(BLOCK_ALPHA_DISABLED);
         this._isDataApplied = true;
      }
      
      private function clearData() : void
      {
         if(this._data != null)
         {
            this._data.dispose();
            this._data = null;
         }
      }
      
      private function onTitleImageChangeHandler(param1:Event) : void
      {
         invalidateBlock();
      }
   }
}
