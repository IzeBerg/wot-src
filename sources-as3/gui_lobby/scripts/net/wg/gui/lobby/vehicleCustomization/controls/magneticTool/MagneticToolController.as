package net.wg.gui.lobby.vehicleCustomization.controls.magneticTool
{
   import flash.display.Sprite;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.lobby.vehicleCustomization.CustomizationMainView;
   import net.wg.gui.lobby.vehicleCustomization.controls.CarouselRendererAttachedBase;
   import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationCarouselRendererVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class MagneticToolController extends EventDispatcher implements IDisposable
   {
      
      private static const CURSOR_OFFSET_X:int = 7;
      
      private static const CURSOR_OFFSET_Y:int = 14;
       
      
      private var _attachedData:CustomizationCarouselRendererVO = null;
      
      private var _enableSelected:Boolean = true;
      
      private var _view:CustomizationMainView;
      
      private var _clickHandlers:Vector.<IMagneticClickHandler>;
      
      public function MagneticToolController(param1:CustomizationMainView, param2:Vector.<IMagneticClickHandler> = null)
      {
         super();
         this._view = param1;
         this._clickHandlers = param2;
      }
      
      public static function isAllSeasonSelected() : Boolean
      {
         var _loc1_:CarouselRendererAttachedBase = App.cursor.getAttachedSprite() as CarouselRendererAttachedBase;
         return _loc1_ && _loc1_.getIsAllSeasons();
      }
      
      public function resetSelect() : void
      {
         if(this._attachedData)
         {
            this._view.vehicleView.onAfterDrop();
            this._attachedData = null;
            if(App.cursor.getAttachedSprite())
            {
               App.cursor.detachFromCursor();
            }
         }
      }
      
      public function get enableSelected() : Boolean
      {
         return this._enableSelected;
      }
      
      public function set enableSelected(param1:Boolean) : void
      {
         this._enableSelected = param1;
      }
      
      public final function dispose() : void
      {
         this.resetSelect();
         this._view = null;
         this._clickHandlers = null;
      }
      
      public function get selectedItemId() : int
      {
         return this._attachedData.intCD;
      }
      
      public function get attachedData() : CustomizationCarouselRendererVO
      {
         return this._attachedData;
      }
      
      public function handleLeftClick(param1:MouseEvent) : Boolean
      {
         var _loc2_:IMagneticClickHandler = param1.target as IMagneticClickHandler;
         if(_loc2_)
         {
            return !_loc2_.handleLeftClick(param1);
         }
         for each(_loc2_ in this._clickHandlers)
         {
            if(_loc2_.handleLeftClick(param1))
            {
               return false;
            }
         }
         return true;
      }
      
      public function attachDataToCursor(param1:CustomizationCarouselRendererVO) : void
      {
         var _loc2_:String = param1.formFactor != Values.DEFAULT_INT ? Linkages.CUSTOMIZATION_DECAL_SWATCH : Linkages.CUSTOMIZATION_ITEM_SWATCH;
         var _loc3_:CarouselRendererAttachedBase = App.utils.classFactory.getComponent(_loc2_,Sprite);
         _loc3_.setData(param1);
         App.cursor.attachToCursor(_loc3_,CURSOR_OFFSET_X,CURSOR_OFFSET_Y);
         this._attachedData = param1;
      }
   }
}
