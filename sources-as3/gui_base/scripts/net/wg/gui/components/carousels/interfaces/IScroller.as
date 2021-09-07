package net.wg.gui.components.carousels.interfaces
{
   import flash.display.Sprite;
   import net.wg.gui.components.controls.scroller.data.ScrollConfig;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.clik.interfaces.IScrollBar;
   
   public interface IScroller extends IUIComponentEx, IScrollerBase
   {
       
      
      function stopScroll() : void;
      
      function goToItem(param1:int, param2:Boolean, param3:Boolean = false) : void;
      
      function startScrollToBegin() : void;
      
      function startScrollToEnd() : void;
      
      function setScrollbar(param1:IScrollBar) : void;
      
      function setHitArea(param1:Sprite) : void;
      
      function get selectedIndex() : int;
      
      function set selectedIndex(param1:int) : void;
      
      function get scrollConfig() : ScrollConfig;
      
      function set scrollConfig(param1:ScrollConfig) : void;
      
      function get snapScrollPositionToItemRendererSize() : Boolean;
      
      function set snapScrollPositionToItemRendererSize(param1:Boolean) : void;
      
      function get snapToPages() : Boolean;
      
      function set snapToPages(param1:Boolean) : void;
      
      function set cropContent(param1:Boolean) : void;
      
      function get goToOffset() : Number;
      
      function set goToOffset(param1:Number) : void;
      
      function get goToIndex() : int;
      
      function get columnCount() : int;
      
      function set columnCount(param1:int) : void;
      
      function get rowCount() : int;
      
      function set rowCount(param1:int) : void;
      
      function get availableScrollLeft() : Boolean;
      
      function get availableScrollRight() : Boolean;
      
      function get availableScrollUp() : Boolean;
      
      function get availableScrollDown() : Boolean;
      
      function get rendererWidth() : int;
      
      function set rendererWidth(param1:int) : void;
      
      function get rendererHeight() : int;
      
      function set rendererHeight(param1:int) : void;
      
      function get dataProvider() : IDataProvider;
      
      function set dataProvider(param1:IDataProvider) : void;
      
      function get itemRendererClassReference() : String;
      
      function set itemRendererClassReference(param1:String) : void;
      
      function get horizontalGap() : int;
      
      function set horizontalGap(param1:int) : void;
      
      function get verticalGap() : int;
      
      function set verticalGap(param1:int) : void;
      
      function get goToDuration() : Number;
      
      function set goToDuration(param1:Number) : void;
      
      function get viewPortClass() : Class;
      
      function usesLayoutController() : Boolean;
      
      function setLayoutController(param1:IScrollerLayoutController) : void;
      
      function get showRendererOnlyIfDataExists() : Boolean;
      
      function set showRendererOnlyIfDataExists(param1:Boolean) : void;
      
      function get useExtendedViewPort() : Boolean;
      
      function set useExtendedViewPort(param1:Boolean) : void;
   }
}
