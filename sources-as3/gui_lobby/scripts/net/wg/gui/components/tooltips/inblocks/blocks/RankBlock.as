package net.wg.gui.components.tooltips.inblocks.blocks
{
   import flash.events.Event;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.tooltips.inblocks.data.RankBlockVO;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class RankBlock extends BaseTooltipBlock
   {
      
      private static const STANDARD_ICON_HEIGHT:int = 160;
      
      private static const PLATE_OFFSET_WIDTH_MULT:Number = 0.8;
      
      private static const PLATE_OFFSET_HEIGHT_MULT:Number = 0.2;
      
      private static const BLOCK_ALPHA_ENABLED:Number = 1;
      
      private static const BLOCK_ALPHA_DISABLED:Number = 0.7;
       
      
      private var _rankImage:Image = null;
      
      private var _shieldImage:Image = null;
      
      private var _plateImage:Image = null;
      
      private var _data:RankBlockVO = null;
      
      private var _isDataApplied:Boolean = false;
      
      private var _blockWidth:Number = 0;
      
      public function RankBlock()
      {
         super();
         this._rankImage = new Image();
         addChild(this._rankImage);
         this._shieldImage = new Image();
         addChild(this._shieldImage);
         this._plateImage = new Image();
         addChild(this._plateImage);
         this._rankImage.addEventListener(Event.CHANGE,this.onRankImageChangeHandler);
         this._shieldImage.addEventListener(Event.CHANGE,this.onShieldImageChangeHandler);
         this._plateImage.addEventListener(Event.CHANGE,this.onPlateImageChangeHandler);
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
         this._data = new RankBlockVO(param1);
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
         removeChild(this._rankImage);
         this._rankImage.removeEventListener(Event.CHANGE,this.onRankImageChangeHandler);
         this._rankImage.dispose();
         this._rankImage = null;
         removeChild(this._shieldImage);
         this._shieldImage.removeEventListener(Event.CHANGE,this.onShieldImageChangeHandler);
         this._shieldImage.dispose();
         this._shieldImage = null;
         removeChild(this._plateImage);
         this._plateImage.removeEventListener(Event.CHANGE,this.onPlateImageChangeHandler);
         this._plateImage.dispose();
         this._plateImage = null;
         super.onDispose();
      }
      
      private function updateLayout() : void
      {
         this._rankImage.x = this._blockWidth - this._rankImage.width >> 1;
         this._rankImage.y = STANDARD_ICON_HEIGHT - this._rankImage.height >> 1;
         if(this._shieldImage.visible)
         {
            this._shieldImage.x = this._blockWidth - this._shieldImage.width >> 1;
            this._shieldImage.y = STANDARD_ICON_HEIGHT - this._shieldImage.height >> 1;
         }
         if(this._plateImage.visible)
         {
            this._plateImage.x = this._shieldImage.x + this._shieldImage.width - this._plateImage.width * PLATE_OFFSET_WIDTH_MULT | 0;
            this._plateImage.y = this._shieldImage.y - this._plateImage.height * PLATE_OFFSET_HEIGHT_MULT | 0;
         }
      }
      
      private function applyData() : void
      {
         this._rankImage.source = this._data.rankImage;
         this._shieldImage.source = this._data.shieldImage;
         this._plateImage.source = this._data.plateImage;
         this._shieldImage.visible = StringUtils.isNotEmpty(this._data.shieldImage);
         this._plateImage.visible = StringUtils.isNotEmpty(this._data.plateImage);
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
      
      private function onRankImageChangeHandler(param1:Event) : void
      {
         invalidateBlock();
      }
      
      private function onShieldImageChangeHandler(param1:Event) : void
      {
         invalidateBlock();
      }
      
      private function onPlateImageChangeHandler(param1:Event) : void
      {
         invalidateBlock();
      }
   }
}
