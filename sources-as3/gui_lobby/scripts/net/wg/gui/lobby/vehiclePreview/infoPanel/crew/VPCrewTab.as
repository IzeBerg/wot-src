package net.wg.gui.lobby.vehiclePreview.infoPanel.crew
{
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.ScrollingListEx;
   import net.wg.gui.lobby.vehiclePreview.VehiclePreviewEvent;
   import net.wg.infrastructure.base.meta.IVehiclePreviewCrewTabMeta;
   import net.wg.infrastructure.base.meta.impl.VehiclePreviewCrewTabMeta;
   import net.wg.infrastructure.interfaces.IViewStackExContent;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.StageSizeBoundaries;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class VPCrewTab extends VehiclePreviewCrewTabMeta implements IViewStackExContent, IVehiclePreviewCrewTabMeta
   {
      
      private static const UNIQUE_CREW_LIST_V_OFFSET:int = 18;
      
      private static const LOCK_CREW_TITLE_V_OFFSET:int = 13;
      
      private static const NORMAL_REGULAR_ROW_H:int = 52;
      
      private static const SMALL_REGULAR_ROW_H:int = 46;
       
      
      public var uniqueCrewList:ScrollingListEx = null;
      
      public var regularCrewList:ScrollingListEx = null;
      
      public var vehicleCrewComment:TextField = null;
      
      public var lockCrewTF:TextField = null;
      
      public var lockCrewIcon:MovieClip = null;
      
      public var skillRenderer:CommonSkillRenderer = null;
      
      private var _toolTipMgr:ITooltipMgr;
      
      public function VPCrewTab()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
         mouseEnabled = false;
      }
      
      override protected function setData(param1:VPCrewTabVO) : void
      {
         this.regularCrewList.height = this.regularCrewList.rowHeight * param1.regularCrewList.length;
         this.regularCrewList.dataProvider = param1.regularCrewList;
         this.uniqueCrewList.height = this.uniqueCrewList.rowHeight * param1.uniqueCrewList.length;
         this.uniqueCrewList.dataProvider = param1.uniqueCrewList;
         this.lockCrewTF.visible = this.lockCrewIcon.visible = param1.lockedCrew;
         if(param1.skillIcon)
         {
            this.skillRenderer.visible = true;
            this.skillRenderer.setData(param1);
            this.vehicleCrewComment.visible = false;
         }
         else
         {
            this.skillRenderer.visible = false;
            this.vehicleCrewComment.htmlText = param1.vehicleCrewComment;
            this.vehicleCrewComment.visible = true;
         }
         invalidateSize();
      }
      
      override protected function onDispose() : void
      {
         this.skillRenderer.removeEventListener(Event.CHANGE,this.onSkillIconChangeHandler);
         this.skillRenderer.dispose();
         this.skillRenderer = null;
         this.uniqueCrewList.removeEventListener(VehiclePreviewEvent.SHOW_TOOLTIP,this.onCrewListShowTooltipHandler);
         this.uniqueCrewList.dispose();
         this.uniqueCrewList = null;
         this.regularCrewList.removeEventListener(VehiclePreviewEvent.SHOW_TOOLTIP,this.onCrewListShowTooltipHandler);
         this.regularCrewList.dispose();
         this.regularCrewList = null;
         this.vehicleCrewComment = null;
         this.lockCrewTF = null;
         this.lockCrewIcon = null;
         this._toolTipMgr = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.lockCrewTF.autoSize = TextFieldAutoSize.LEFT;
         this.lockCrewTF.text = VEHICLE_PREVIEW.INFOPANEL_TAB_CREWINFO_LOCKTITLE;
         this.lockCrewTF.mouseWheelEnabled = this.lockCrewTF.mouseEnabled = false;
         this.lockCrewIcon.mouseEnabled = this.lockCrewIcon.mouseChildren = false;
         this.vehicleCrewComment.autoSize = TextFieldAutoSize.LEFT;
         this.vehicleCrewComment.mouseWheelEnabled = this.vehicleCrewComment.mouseEnabled = false;
         this.vehicleCrewComment.wordWrap = true;
         this.vehicleCrewComment.multiline = true;
         this.skillRenderer.addEventListener(Event.CHANGE,this.onSkillIconChangeHandler);
         this.uniqueCrewList.addEventListener(VehiclePreviewEvent.SHOW_TOOLTIP,this.onCrewListShowTooltipHandler);
         this.regularCrewList.addEventListener(VehiclePreviewEvent.SHOW_TOOLTIP,this.onCrewListShowTooltipHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            if(App.appHeight < StageSizeBoundaries.HEIGHT_900)
            {
               this.regularCrewList.rowHeight = SMALL_REGULAR_ROW_H;
            }
            else
            {
               this.regularCrewList.rowHeight = NORMAL_REGULAR_ROW_H;
            }
            this.regularCrewList.height = this.regularCrewList.rowHeight * this.regularCrewList.dataProvider.length;
            if(this.skillRenderer.visible)
            {
               this.skillRenderer.width = this.uniqueCrewList.x + this.uniqueCrewList.width - this.skillRenderer.x;
               this.skillRenderer.validateNow();
               this.uniqueCrewList.y = this.skillRenderer.y + this.skillRenderer.actualHeight + UNIQUE_CREW_LIST_V_OFFSET;
            }
            else
            {
               this.vehicleCrewComment.width = this.regularCrewList.x + this.regularCrewList.width - this.vehicleCrewComment.x;
               this.uniqueCrewList.y = this.vehicleCrewComment.y + this.vehicleCrewComment.height + UNIQUE_CREW_LIST_V_OFFSET;
            }
            this.regularCrewList.y = this.uniqueCrewList.y + this.uniqueCrewList.height;
            if(this.lockCrewTF.visible)
            {
               this.lockCrewTF.y = this.regularCrewList.y + this.regularCrewList.height + LOCK_CREW_TITLE_V_OFFSET;
               this.lockCrewIcon.y = this.lockCrewTF.y + (this.lockCrewTF.height - this.lockCrewIcon.height >> 1);
               height = this.lockCrewTF.y + this.lockCrewTF.height;
            }
            else
            {
               height = this.regularCrewList.y + this.regularCrewList.height;
            }
         }
      }
      
      public function canShowAutomatically() : Boolean
      {
         return true;
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return null;
      }
      
      public function setActive(param1:Boolean) : void
      {
         setActiveStateS(param1);
      }
      
      public function update(param1:Object) : void
      {
      }
      
      private function onSkillIconChangeHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function onCrewListShowTooltipHandler(param1:VehiclePreviewEvent) : void
      {
         var _loc3_:Array = null;
         param1.stopImmediatePropagation();
         var _loc2_:VPCrewRendererVO = VPCrewRendererVO(param1.data);
         if(_loc2_.crewId == -1)
         {
            this._toolTipMgr.showComplex(_loc2_.tooltip);
         }
         else if(StringUtils.isNotEmpty(_loc2_.tooltip))
         {
            _loc3_ = getTooltipDataS(_loc2_.crewId,_loc2_.slotIdx);
            this._toolTipMgr.showSpecial.apply(null,[_loc2_.tooltip,null].concat(_loc3_));
         }
      }
   }
}
