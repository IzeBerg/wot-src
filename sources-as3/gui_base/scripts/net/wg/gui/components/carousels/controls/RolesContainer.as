package net.wg.gui.components.carousels.controls
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.carousels.VehiclesFilterPopoverContent;
   import net.wg.gui.components.carousels.data.FilterRoleItemData;
   import net.wg.gui.components.carousels.events.FiltersTileListEvent;
   import net.wg.gui.components.controls.events.RendererEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.DirectionMode;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   
   public class RolesContainer extends UIComponentEx
   {
      
      private static const LIST_OFFSET:int = 4;
      
      private static const ARROW_X_START:int = 18;
      
      private static const ARROW_X_STEP:int = 45;
      
      private static const ALPHA_ANIM_DURATION:uint = 180;
      
      private static const STEP_ANIM_DURATION:uint = 30;
      
      private static const STEPS_NUMBER:uint = 5;
       
      
      public var titleRoles:TextField = null;
      
      public var listRoles:RolesTileList = null;
      
      public var separatorTop:DisplayObject = null;
      
      public var separatorBottom:DisplayObject = null;
      
      public var arrow:DisplayObject = null;
      
      public var bg:DisplayObject = null;
      
      private var _data:FilterRoleItemData = null;
      
      private var _currentStep:int = 0;
      
      private var _isVisible:Boolean = false;
      
      private var _heightTween:Tween = null;
      
      private var _alphaTween:Tween = null;
      
      public function RolesContainer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.listRoles.itemRenderer = App.utils.classFactory.getClass(Linkages.GHOST_TOGGLE_RENDERER_UI);
         this.listRoles.tileWidth = VehiclesFilterPopoverContent.TOGGLE_TILE_WIDTH;
         this.listRoles.tileHeight = VehiclesFilterPopoverContent.TOGGLE_TILE_HEIGHT;
         this.listRoles.directionMode = DirectionMode.HORIZONTAL;
         this.listRoles.addEventListener(Event.COMPLETE,this.onListRolesCompleteHandler);
         this.listRoles.addEventListener(RendererEvent.ITEM_CLICK,this.onVehicleRoleItemClickHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.titleRoles.htmlText = this._data.label;
               this.listRoles.dataProvider = this._data.dataProvider;
               invalidateLayout();
            }
            if(isInvalid(InvalidationType.LAYOUT))
            {
               this.arrow.x = ARROW_X_START + this._data.selectedVehTypeIdx * ARROW_X_STEP;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.listRoles.removeEventListener(Event.COMPLETE,this.onListRolesCompleteHandler);
         this.listRoles.removeEventListener(RendererEvent.ITEM_CLICK,this.onVehicleRoleItemClickHandler);
         this.listRoles.dispose();
         this.listRoles = null;
         this.titleRoles = null;
         this.separatorBottom = null;
         this.separatorTop = null;
         this.arrow = null;
         this.bg = null;
         this._data = null;
         this.clearTweens();
         super.onDispose();
      }
      
      public function clearList() : void
      {
         this.listRoles.dataProvider = null;
      }
      
      public function setAnimVisibility(param1:Boolean) : void
      {
         if(this._isVisible == param1)
         {
            return;
         }
         this._isVisible = param1;
         if(this._isVisible)
         {
            alpha = 0;
            this.visible = true;
            this._currentStep = 0;
         }
         else
         {
            this._currentStep = STEPS_NUMBER;
         }
         this.clearTweens();
         this._heightTween = new Tween(STEP_ANIM_DURATION,this,{},{
            "paused":false,
            "onComplete":this.onHeightTweenComplete
         });
         this._alphaTween = new Tween(ALPHA_ANIM_DURATION,this,{"alpha":(!!this._isVisible ? 1 : 0)},{"paused":false});
      }
      
      public function setData(param1:FilterRoleItemData) : void
      {
         if(this._data != param1 && param1 != null)
         {
            this._data = param1;
            invalidateData();
         }
      }
      
      private function clearTweens() : void
      {
         if(this._heightTween)
         {
            this._heightTween.dispose();
            this._heightTween = null;
         }
         if(this._alphaTween)
         {
            this._alphaTween.dispose();
            this._alphaTween = null;
         }
      }
      
      private function onHeightTweenComplete(param1:Tween) : void
      {
         this._currentStep += !!this._isVisible ? 1 : -1;
         if(this._currentStep <= STEPS_NUMBER && this._currentStep >= 0)
         {
            dispatchEvent(new Event(Event.RESIZE));
            param1.paused = false;
         }
         else
         {
            alpha = 1;
            this.visible = this._isVisible;
         }
      }
      
      override public function get height() : Number
      {
         return (this.bg.height + LIST_OFFSET) * (this._currentStep / STEPS_NUMBER);
      }
      
      override public function set visible(param1:Boolean) : void
      {
         this._currentStep = STEPS_NUMBER;
         this._isVisible = param1;
         super.visible = param1;
      }
      
      private function onListRolesCompleteHandler(param1:Event) : void
      {
         dispatchEvent(param1.clone());
      }
      
      private function onVehicleRoleItemClickHandler(param1:RendererEvent) : void
      {
         dispatchEvent(new FiltersTileListEvent(FiltersTileListEvent.ITEM_CLICK,this._data.sectionId,param1.index));
      }
   }
}
