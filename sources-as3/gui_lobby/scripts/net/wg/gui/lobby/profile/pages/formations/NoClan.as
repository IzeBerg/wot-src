package net.wg.gui.lobby.profile.pages.formations
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class NoClan extends Sprite implements IDisposable
   {
       
      
      public var searchClanText:TextField;
      
      public var createClanText:TextField;
      
      public var title:TextField;
      
      private var _wordGap:int = 32;
      
      private var _initialWidth:int;
      
      private var _disposed:Boolean = false;
      
      public function NoClan()
      {
         super();
         this._initialWidth = this.title.width;
         this._wordGap = this.createClanText.x - this.searchClanText.x;
         this.searchClanText.autoSize = this.createClanText.autoSize = TextFieldAutoSize.LEFT;
         this.createClanText.addEventListener(MouseEvent.MOUSE_OVER,this.onCreateClanTextMouseOver);
         this.createClanText.addEventListener(MouseEvent.MOUSE_OUT,this.onLinkTextfieldMouseOut);
         this.createClanText.addEventListener(TextEvent.LINK,this.onLinkNavigationHandler);
         this.searchClanText.addEventListener(MouseEvent.MOUSE_OVER,this.onSearchClanTextMouseOver);
         this.searchClanText.addEventListener(MouseEvent.MOUSE_OUT,this.onLinkTextfieldMouseOut);
         this.searchClanText.addEventListener(TextEvent.LINK,this.onLinkNavigationHandler);
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.createClanText.removeEventListener(MouseEvent.MOUSE_OVER,this.onCreateClanTextMouseOver);
         this.createClanText.removeEventListener(MouseEvent.MOUSE_OUT,this.onLinkTextfieldMouseOut);
         this.createClanText.removeEventListener(TextEvent.LINK,this.onLinkNavigationHandler);
         this.createClanText.styleSheet = null;
         this.createClanText = null;
         this.searchClanText.removeEventListener(MouseEvent.MOUSE_OVER,this.onSearchClanTextMouseOver);
         this.searchClanText.removeEventListener(MouseEvent.MOUSE_OUT,this.onLinkTextfieldMouseOut);
         this.searchClanText.removeEventListener(TextEvent.LINK,this.onLinkNavigationHandler);
         this.searchClanText.styleSheet = null;
         this.searchClanText = null;
         this.title = null;
      }
      
      public function hideLinks() : void
      {
         this.searchClanText.visible = false;
         this.createClanText.visible = false;
      }
      
      public function initLinks(param1:String, param2:String) : void
      {
         this.searchClanText.visible = true;
         this.searchClanText.htmlText = param1;
         App.utils.styleSheetManager.setLinkStyle(this.searchClanText);
         this.createClanText.visible = true;
         this.createClanText.htmlText = param2;
         App.utils.styleSheetManager.setLinkStyle(this.createClanText);
         var _loc3_:int = this.searchClanText.textWidth + this._wordGap + this.createClanText.textWidth;
         this.searchClanText.x = 0.5 * (this._initialWidth - _loc3_);
         this.createClanText.x = this.searchClanText.x + this.searchClanText.textWidth + this._wordGap;
      }
      
      private function onCreateClanTextMouseOver(param1:MouseEvent) : void
      {
         App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_WELCOME_CLANCREATE);
      }
      
      private function onSearchClanTextMouseOver(param1:MouseEvent) : void
      {
         App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_WELCOME_CLANSEARCH);
      }
      
      private function onLinkNavigationHandler(param1:TextEvent) : void
      {
         dispatchEvent(new LinkNavigationEvent(param1.text));
      }
      
      private function onLinkTextfieldMouseOut(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
