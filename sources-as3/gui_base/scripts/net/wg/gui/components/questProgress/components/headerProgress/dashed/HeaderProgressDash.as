package net.wg.gui.components.questProgress.components.headerProgress.dashed
{
   import net.wg.data.constants.generated.QUEST_PROGRESS_BASE;
   import net.wg.gui.components.common.FrameStateCmpnt;
   import net.wg.gui.components.controls.BitmapFill;
   import net.wg.gui.components.questProgress.interfaces.components.IHeaderProgressDash;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class HeaderProgressDash extends UIComponentEx implements IHeaderProgressDash
   {
      
      private static const DASH_HORIZONTAL_ADDITIONAL_WIDTH:int = 32;
       
      
      public var bg:FrameStateCmpnt = null;
      
      public var bmFill:BitmapFill = null;
      
      private var _state:String = "";
      
      private var _maxWidth:int = 0;
      
      private var _isLast:Boolean = false;
      
      private var _isDataDirty:Boolean = false;
      
      public function HeaderProgressDash()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.bg.allowResize = true;
         this.setBmFill();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._isDataDirty && isInvalid(InvalidationType.DATA))
         {
            this.updateItem(this._maxWidth,this._state,this._isLast);
         }
      }
      
      override protected function onDispose() : void
      {
         this.bmFill.dispose();
         this.bmFill = null;
         this.bg.dispose();
         this.bg = null;
         super.onDispose();
      }
      
      public function setData(param1:int, param2:String, param3:Boolean) : void
      {
         this._maxWidth = param1;
         this._state = param2;
         this._isLast = param3;
         this._isDataDirty = true;
         invalidateData();
      }
      
      protected function setBmFill() : void
      {
         this.bmFill.source = QUEST_PROGRESS_BASE.HEADER_PROGRESS_BITMAP_FILL;
         this.bmFill.heightFill = QUEST_PROGRESS_BASE.HEADER_PROGRESS_BITMAP_FILL_HEIGHT;
         this.bmFill.repeat = BitmapFill.REPEAT_HORIZONTAL;
      }
      
      protected function getDashHorizontalAdditionalWidth() : int
      {
         return DASH_HORIZONTAL_ADDITIONAL_WIDTH;
      }
      
      protected function updateItem(param1:int, param2:String, param3:Boolean) : void
      {
         this.bg.frameLabel = param2;
         this.bg.width = param1 + this.getDashHorizontalAdditionalWidth();
         this.bmFill.widthFill = param1;
      }
   }
}
