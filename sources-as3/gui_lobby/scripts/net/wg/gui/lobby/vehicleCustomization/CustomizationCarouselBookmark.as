package net.wg.gui.lobby.vehicleCustomization
{
   import flash.display.BlendMode;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class CustomizationCarouselBookmark extends UIComponentEx
   {
      
      private static const DOTS:String = "...";
       
      
      public var bookmarkNameTF:TextField = null;
      
      private var _fullName:String = null;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _isBookmarkNameTextTruncated:Boolean = false;
      
      public function CustomizationCarouselBookmark()
      {
         this._tooltipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         blendMode = BlendMode.ADD;
      }
      
      override protected function onDispose() : void
      {
         this.removeBookmarkNameTextListeners();
         this.bookmarkNameTF = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      public function setBookmarkNameText(param1:String, param2:Boolean) : void
      {
         var _loc3_:String = null;
         this.bookmarkNameTF.autoSize = TextFieldAutoSize.LEFT;
         this.bookmarkNameTF.htmlText = param1;
         if(param2)
         {
            this.bookmarkNameTF.autoSize = TextFieldAutoSize.NONE;
            this.bookmarkNameTF.width = _width;
            this.removeBookmarkNameTextListeners();
            this._fullName = param1;
            _loc3_ = App.utils.commons.truncateTextFieldText(this.bookmarkNameTF,param1,true,true,DOTS);
            this._isBookmarkNameTextTruncated = !StringUtils.equals(param1,_loc3_);
            if(this._isBookmarkNameTextTruncated)
            {
               this.bookmarkNameTF.addEventListener(MouseEvent.ROLL_OVER,this.onBookmarkNameTextRollOverHandler);
               this.bookmarkNameTF.addEventListener(MouseEvent.ROLL_OUT,this.onBookmarkNameTextRollOutHandler);
            }
         }
      }
      
      private function removeBookmarkNameTextListeners() : void
      {
         if(this._isBookmarkNameTextTruncated)
         {
            this.bookmarkNameTF.removeEventListener(MouseEvent.ROLL_OVER,this.onBookmarkNameTextRollOverHandler);
            this.bookmarkNameTF.removeEventListener(MouseEvent.ROLL_OUT,this.onBookmarkNameTextRollOutHandler);
         }
      }
      
      private function onBookmarkNameTextRollOverHandler(param1:MouseEvent) : void
      {
         if(this._fullName != null)
         {
            this._tooltipMgr.show(this._fullName);
         }
      }
      
      private function onBookmarkNameTextRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
   }
}
