package net.wg.gui.lobby.eventBoards.components
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.popovers.events.VehicleSelectRendererEvent;
   import net.wg.gui.lobby.eventBoards.data.VehicleRendererItemVO;
   import net.wg.infrastructure.interfaces.IImage;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class VehicleSelectorItemRenderer extends SoundListItemRenderer
   {
      
      private static const VEH_TYPE_MIDDLE_X:int = 73;
       
      
      public var flagLoader:UILoaderAlt;
      
      public var tankIcon:UILoaderAlt;
      
      public var inHangar:UILoaderAlt;
      
      public var vehicleTypeIcon:IImage;
      
      public var levelIcon:MovieClip;
      
      public var vehicleNameTF:TextField;
      
      protected var dataVO:VehicleRendererItemVO = null;
      
      public function VehicleSelectorItemRenderer()
      {
         super();
         selectable = true;
         toggle = true;
      }
      
      override public function setData(param1:Object) : void
      {
         this.dataVO = VehicleRendererItemVO(param1);
         if(this.dataVO)
         {
            visible = true;
            invalidateData();
         }
         else
         {
            visible = false;
         }
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(ButtonEvent.CLICK,this.onClickHandler);
         this.flagLoader.dispose();
         this.tankIcon.dispose();
         this.inHangar.dispose();
         this.dataVO = null;
         this.vehicleNameTF = null;
         this.levelIcon = null;
         this.vehicleTypeIcon.removeEventListener(Event.CHANGE,this.onVehicleTypeIconChangeHandler);
         this.vehicleTypeIcon.dispose();
         this.vehicleTypeIcon = null;
         this.flagLoader = null;
         this.tankIcon = null;
         this.inHangar = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            _loc1_ = this.dataVO != null;
            if(_loc1_)
            {
               this.selected = this.dataVO.selected;
               this.vehicleNameTF.htmlText = this.dataVO.shortUserName;
               this.vehicleTypeIcon.source = this.dataVO.typeIcon;
               this.levelIcon.gotoAndStop(this.dataVO.level);
               this.flagLoader.source = App.utils.nations.getNationIcon(this.dataVO.nationID);
               this.tankIcon.source = this.dataVO.smallIconPath;
               this.inHangar.visible = this.dataVO.inHangar;
            }
            this.vehicleNameTF.visible = _loc1_;
            this.vehicleTypeIcon.visible = _loc1_;
            this.levelIcon.visible = _loc1_;
            this.flagLoader.visible = _loc1_;
            this.tankIcon.visible = _loc1_;
            if(!_loc1_)
            {
               this.inHangar.visible = false;
            }
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(ButtonEvent.CLICK,this.onClickHandler);
         this.inHangar.source = RES_ICONS.MAPS_ICONS_BUTTONS_ICON_TABLE_COMPARISON_CHECKMARK;
         this.vehicleTypeIcon.addEventListener(Event.CHANGE,this.onVehicleTypeIconChangeHandler);
      }
      
      override public function set height(param1:Number) : void
      {
      }
      
      private function onVehicleTypeIconChangeHandler(param1:Event) : void
      {
         this.updateLayout();
      }
      
      private function onClickHandler(param1:ButtonEvent) : void
      {
         setState(state);
         dispatchEvent(new VehicleSelectRendererEvent(VehicleSelectRendererEvent.RENDERER_CLICK,this.dataVO.dbID,false,true));
         if(owner)
         {
            owner.invalidate(InvalidationType.STATE);
         }
      }
      
      protected function updateLayout() : void
      {
         this.vehicleTypeIcon.x = VEH_TYPE_MIDDLE_X - (this.vehicleTypeIcon.width >> 1);
      }
   }
}
