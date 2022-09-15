package net.wg.gui.lobby.personalMissions.components.firstEntry
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.gui.lobby.personalMissions.data.InfoAdditionalBlockDataVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class InfoAdditionalBlock extends Sprite implements IDisposable
   {
      
      private static const DESCRIPTION_TOP_GAP:int = 8;
      
      private static const TEXT_FIELD_LEFT_SHIFT:int = -3;
      
      private static const BLOCK_GAP:int = 24;
      
      private static const TEXT_FIELD_BOTTOM_HEIGHT_CUT:int = -1;
       
      
      public var titleTf:TextField = null;
      
      public var descriptionTf:TextField = null;
      
      public var image:UILoaderAlt = null;
      
      private var _fontSize:int = 0;
      
      private var _data:InfoAdditionalBlockDataVO = null;
      
      private var _blockMinWidth:int = 0;
      
      private var _blockMinHeight:int = 0;
      
      private var _isInverse:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      public function InfoAdditionalBlock()
      {
         super();
         this.image.maintainAspectRatio = false;
         this.image.addEventListener(UILoaderEvent.COMPLETE,this.onImageLoadCompleteHandler);
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this._data = null;
         this.image.removeEventListener(UILoaderEvent.COMPLETE,this.onImageLoadCompleteHandler);
         this.image.dispose();
         this.image = null;
         this.titleTf = null;
         this.descriptionTf = null;
      }
      
      public function setBlockSettings(param1:int, param2:int, param3:int) : void
      {
         this._blockMinWidth = param1;
         this._blockMinHeight = param2;
         this._fontSize = param3;
         this.titleTf.width = this._blockMinWidth;
         this.descriptionTf.width = this._blockMinWidth;
         this.updateTextFields();
         this.updateImageSize();
         var _loc4_:int = BLOCK_GAP >> 1;
         if(this._isInverse)
         {
            this.titleTf.x = _loc4_ + TEXT_FIELD_LEFT_SHIFT;
            this.image.x = -this._blockMinWidth - _loc4_;
            this.descriptionTf.x = this.titleTf.x;
         }
         else
         {
            this.titleTf.x = this.descriptionTf.x = -this._blockMinWidth - _loc4_ + TEXT_FIELD_LEFT_SHIFT;
         }
      }
      
      public function setData(param1:InfoAdditionalBlockDataVO, param2:Boolean) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._data = param1;
         this._isInverse = param2;
         this.updateTextFields();
         this.image.source = this._data.image;
      }
      
      private function updateImageSize() : void
      {
         this.image.setOriginalWidth(this._blockMinWidth);
         this.image.setOriginalHeight(this._blockMinHeight);
         this.image.updateLoaderSize();
      }
      
      private function updateTextFields() : void
      {
         var _loc1_:TextFormat = this.descriptionTf.getTextFormat();
         _loc1_.size = this._fontSize;
         this.descriptionTf.text = this._data.description;
         this.descriptionTf.setTextFormat(_loc1_);
         this.titleTf.text = this._data.title;
         App.utils.commons.updateTextFieldSize(this.titleTf,false,true);
         App.utils.commons.updateTextFieldSize(this.descriptionTf,false,true);
         this.descriptionTf.y = this.titleTf.height + DESCRIPTION_TOP_GAP;
      }
      
      public function get contentHeight() : int
      {
         return Math.max(this._blockMinHeight,this.descriptionTf.y + this.descriptionTf.textHeight + TEXT_FIELD_BOTTOM_HEIGHT_CUT);
      }
      
      private function onImageLoadCompleteHandler(param1:UILoaderEvent) : void
      {
         this.updateImageSize();
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
