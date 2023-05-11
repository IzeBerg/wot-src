package net.wg.gui.lobby.eventBoards.components
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.controls.TableRenderer;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.eventBoards.data.EventBoardsVehicleVO;
   import net.wg.utils.ICommons;
   import scaleform.clik.constants.InvalidationType;
   
   public class VehicleItemRenderer extends TableRenderer
   {
      
      private static const LEVEL_POS:int = 115;
      
      private static const VEH_TYPE_MIDDLE_X:int = 73;
      
      private static const RENDERER_HEIGHT:int = 28;
       
      
      public var flagLoader:UILoaderAlt;
      
      public var tankIcon:UILoaderAlt;
      
      public var vehicleTypeIcon:Image;
      
      public var levelIcon:MovieClip;
      
      public var vehicleNameTF:TextField;
      
      public var emptyStateTF:TextField;
      
      public var inHangarIcon:MovieClip;
      
      private var _model:EventBoardsVehicleVO;
      
      private var _commons:ICommons;
      
      public function VehicleItemRenderer()
      {
         super();
         this._commons = App.utils.commons;
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         this._model = EventBoardsVehicleVO(param1);
         invalidateData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.vehicleTypeIcon.addEventListener(Event.CHANGE,this.onVehicleTypeIconChangeHandler);
         this.inHangarIcon.addEventListener(MouseEvent.ROLL_OVER,this.onIconRollOverHandler);
         this.inHangarIcon.addEventListener(MouseEvent.ROLL_OUT,this.onIconRollOutHandler);
         this.inHangarIcon.visible = false;
         this.emptyStateTF.visible = false;
         this.emptyStateTF.text = "";
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            _loc1_ = this._model != null;
            this.vehicleNameTF.visible = this.vehicleTypeIcon.visible = this.levelIcon.visible = this.flagLoader.visible = this.tankIcon.visible = this.inHangarIcon.visible = _loc1_;
            if(_loc1_)
            {
               this.vehicleNameTF.htmlText = this._model.vehicleName;
               this.vehicleTypeIcon.source = this._model.typeIconPath;
               this.levelIcon.gotoAndStop(this._model.level);
               this.levelIcon.x = LEVEL_POS - (this.levelIcon.width >> 1);
               this.flagLoader.source = this._model.nationIconPath;
               this.tankIcon.source = this._model.smallVehicleIconPath;
               this.inHangarIcon.visible = this._model.isInHangar;
               this.emptyStateTF.visible = false;
            }
            else
            {
               this.emptyStateTF.visible = true;
            }
         }
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         mouseChildren = param1;
      }
      
      override protected function onDispose() : void
      {
         this.flagLoader.dispose();
         this.flagLoader = null;
         this.tankIcon.dispose();
         this.tankIcon = null;
         this.vehicleNameTF = null;
         this.emptyStateTF = null;
         this.levelIcon = null;
         this.inHangarIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onIconRollOverHandler);
         this.inHangarIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onIconRollOutHandler);
         this.inHangarIcon = null;
         this.vehicleTypeIcon.removeEventListener(Event.CHANGE,this.onVehicleTypeIconChangeHandler);
         this.vehicleTypeIcon.dispose();
         this.vehicleTypeIcon = null;
         this._commons = null;
         this._model = null;
         super.onDispose();
      }
      
      private function onVehicleTypeIconChangeHandler(param1:Event) : void
      {
         this.vehicleTypeIcon.x = VEH_TYPE_MIDDLE_X - (this.vehicleTypeIcon.width >> 1);
         this.vehicleTypeIcon.y = RENDERER_HEIGHT - this.vehicleTypeIcon.height >> 1;
      }
      
      private function onIconRollOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.show(EVENT_BOARDS.CONDITION_VEHICLE_EXIST);
      }
      
      private function onIconRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
   }
}
