package net.wg.gui.lobby.vehicleCustomization
{
   import flash.display.MovieClip;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import net.wg.gui.components.carousels.HorizontalScroller;
   import net.wg.gui.components.carousels.interfaces.IScroller;
   import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationCarouselArrowVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class CustomizationCarouselLayoutRenderer implements IDisposable
   {
      
      private static const SEPARATOR_BIG_MOVIE:String = "SeparatorBigUI";
      
      private static const SEPARATOR_SMALL_MOVIE:String = "SeparatorSmallUI";
      
      private static const ITEM_ARROW_BIG_MOVIE:String = "ItemArrowBigUI";
      
      private static const ITEM_ARROW_SMALL_MOVIE:String = "ItemArrowSmallUI";
      
      private static const ARROW_ENABLED_STATE:String = "enabled";
      
      private static const ARROW_DISABLED_STATE:String = "disabled";
      
      private static const MIN_RESOLUTION:int = 900;
       
      
      private var _scrollList:IScroller = null;
      
      private var _layoutController:CustomizationCarouselLayoutController = null;
      
      private var _separatorItems:Vector.<MovieClip>;
      
      private var _arrowItems:Vector.<MovieClip>;
      
      private var _isMinResolution:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      public function CustomizationCarouselLayoutRenderer(param1:IScroller, param2:CustomizationCarouselLayoutController)
      {
         this._separatorItems = new Vector.<MovieClip>();
         this._arrowItems = new Vector.<MovieClip>();
         super();
         this._scrollList = param1;
         this._layoutController = param2;
      }
      
      public function dispose() : void
      {
         this.cleanUpItems(this._arrowItems);
         this.cleanUpItems(this._separatorItems);
         this._arrowItems = null;
         this._separatorItems = null;
         this._scrollList = null;
         this._layoutController = null;
         this._disposed = true;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function render() : void
      {
         var _loc3_:CustomizationCarouselArrowVO = null;
         var _loc4_:Point = null;
         this._isMinResolution = App.appHeight < MIN_RESOLUTION;
         var _loc1_:Dictionary = this._layoutController.getArrowsLayout();
         var _loc2_:Vector.<Point> = this._layoutController.getSeparatorsLayout();
         this.cleanUpItems(this._arrowItems);
         this.cleanUpItems(this._separatorItems);
         for each(_loc3_ in _loc1_)
         {
            if(_loc3_.position)
            {
               this.addArrowItem(_loc3_.position,_loc3_.enabled);
            }
         }
         for each(_loc4_ in _loc2_)
         {
            this.addSeparatorItem(_loc4_);
         }
      }
      
      private function cleanUpItems(param1:Vector.<MovieClip>) : void
      {
         var _loc2_:MovieClip = null;
         for each(_loc2_ in param1)
         {
            HorizontalScroller(this._scrollList).removeUnmanagedChild(_loc2_);
         }
         param1.splice(0,param1.length);
      }
      
      private function addSeparatorItem(param1:Point) : void
      {
         var _loc2_:Class = App.instance.utils.classFactory.getClass(!!this._isMinResolution ? SEPARATOR_SMALL_MOVIE : SEPARATOR_BIG_MOVIE);
         var _loc3_:MovieClip = new _loc2_() as MovieClip;
         if(_loc3_ != null)
         {
            HorizontalScroller(this._scrollList).addUnmanagedChild(_loc3_,0);
            _loc3_.x = param1.x;
            this._separatorItems.push(_loc3_);
         }
      }
      
      private function addArrowItem(param1:Point, param2:Boolean) : void
      {
         var _loc4_:MovieClip = null;
         var _loc3_:Class = App.instance.utils.classFactory.getClass(!!this._isMinResolution ? ITEM_ARROW_SMALL_MOVIE : ITEM_ARROW_BIG_MOVIE);
         _loc4_ = new _loc3_() as MovieClip;
         if(_loc4_ != null)
         {
            _loc4_.gotoAndStop(!!param2 ? ARROW_ENABLED_STATE : ARROW_DISABLED_STATE);
            HorizontalScroller(this._scrollList).addUnmanagedChild(_loc4_,0);
            _loc4_.x = param1.x;
            _loc4_.y = param1.y;
            this._arrowItems.push(_loc4_);
         }
      }
   }
}
