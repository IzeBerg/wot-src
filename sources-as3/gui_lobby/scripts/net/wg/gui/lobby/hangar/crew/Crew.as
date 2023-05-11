package net.wg.gui.lobby.hangar.crew
{
   import flash.display.MovieClip;
   import flash.display.Stage;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.events.CrewEvent;
   import net.wg.gui.events.ListEventEx;
   import net.wg.gui.lobby.hangar.crew.ev.CrewDogEvent;
   import net.wg.infrastructure.base.meta.impl.CrewMeta;
   import net.wg.utils.helpLayout.HelpLayoutVO;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class Crew extends CrewMeta implements ICrew
   {
      
      private static const INVALIDATE_ENABLE:String = "invalidateEnable";
      
      private static const DOG_UI:String = "crewDogItemUI";
      
      private static const MAX_CREW:int = 6;
      
      private static const DEFAULT_RENDERER_HEIGHT:int = 61;
      
      private static const SMALL_RENDERER_HEIGHT:int = 50;
       
      
      public var list:CrewScrollingList = null;
      
      public var maskMC:MovieClip = null;
      
      public var bg:MovieClip = null;
      
      [Inspectable(defaultValue="R",enumeration="T,L,B,R",verbose="1")]
      public var helpDirection:String = "R";
      
      [Inspectable(defaultValue="",verbose="1")]
      public var helpText:String = "";
      
      [Inspectable(defaultValue="12",verbose="1")]
      public var helpConnectorLength:Number = 12;
      
      private var _helpLayoutId:String = "";
      
      private var _crewDogItem:CrewDogItem = null;
      
      private var _stage:Stage = null;
      
      public function Crew()
      {
         super();
         this._stage = App.stage;
      }
      
      private static function onListItemRollOverHandler(param1:ListEventEx) : void
      {
         var _loc2_:TankmanRoleVO = TankmanRoleVO(param1.itemData);
         if(_loc2_.tankmanID)
         {
            App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.TANKMAN,null,_loc2_.tankmanID,true);
         }
      }
      
      private static function onListHideTooltipHandler(param1:ListEventEx) : void
      {
         App.toolTipMgr.hide();
      }
      
      override protected function onBeforeDispose() : void
      {
         this._stage.removeEventListener(CrewEvent.OPEN_PERSONAL_CASE,this.onStageOpenPersonalCaseHandler);
         this._stage.removeEventListener(CrewEvent.SHOW_RECRUIT_WINDOW,this.onStageShowRecruitWindowHandler);
         this._stage.removeEventListener(CrewEvent.EQUIP_TANKMAN,this.onStageEquipTankmanHandler);
         this.list.removeEventListener(ListEventEx.ITEM_ROLL_OVER,onListItemRollOverHandler);
         this.list.removeEventListener(ListEventEx.ITEM_ROLL_OUT,onListHideTooltipHandler);
         this.list.removeEventListener(ListEventEx.ITEM_PRESS,onListHideTooltipHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this._stage = null;
         this.list.dispose();
         this.list = null;
         this.bg = null;
         this.removeDogItem();
         this.maskMC = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseEnabled = false;
         this.bg.mouseEnabled = false;
         this._stage.addEventListener(CrewEvent.OPEN_PERSONAL_CASE,this.onStageOpenPersonalCaseHandler);
         this._stage.addEventListener(CrewEvent.EQUIP_TANKMAN,this.onStageEquipTankmanHandler);
         this._stage.addEventListener(CrewEvent.SHOW_RECRUIT_WINDOW,this.onStageShowRecruitWindowHandler);
         this.list.addEventListener(ListEventEx.ITEM_ROLL_OVER,onListItemRollOverHandler);
         this.list.addEventListener(ListEventEx.ITEM_ROLL_OUT,onListHideTooltipHandler);
         this.list.addEventListener(ListEventEx.ITEM_PRESS,onListHideTooltipHandler);
         this.list.mouseEnabled = false;
         this.list.mask = this.maskMC;
         App.utils.helpLayout.registerComponent(this);
      }
      
      override protected function draw() : void
      {
         if(isInvalid(INVALIDATE_ENABLE))
         {
            this.list.enabled = enabled;
            if(this._crewDogItem)
            {
               this._crewDogItem.enabled = enabled;
            }
         }
         super.draw();
      }
      
      override protected function tankmenResponse(param1:TankmenResponseVO) : void
      {
         this.list.dataProvider = param1.listDP;
         this.list.selectedIndex = -1;
         this.updateDogItemPosition();
         invalidate(INVALIDATE_ENABLE);
      }
      
      public function as_dogResponse(param1:String) : void
      {
         if(StringUtils.isNotEmpty(param1))
         {
            if(!this._crewDogItem)
            {
               this._crewDogItem = App.utils.classFactory.getComponent(DOG_UI,CrewDogItem);
               this._crewDogItem.addEventListener(CrewDogEvent.TO_MORE_INFO_CLICK,this.onCrewDogItemToMoreInfoClickHandler);
               this._crewDogItem.addEventListener(CrewDogEvent.ON_ITEM_CLICK,this.onCrewDogItemOnItemClickHandler);
               this.addChild(this._crewDogItem);
            }
            this._crewDogItem.setData(param1);
            this._crewDogItem.enabled = enabled;
         }
         else
         {
            this.removeDogItem();
         }
         this.updateDogItemPosition();
      }
      
      public function as_setDogTooltip(param1:String) : void
      {
         if(this._crewDogItem)
         {
            this._crewDogItem.setTooltip(param1);
         }
      }
      
      public function getLayoutProperties() : Vector.<HelpLayoutVO>
      {
         if(!this._helpLayoutId)
         {
            this._helpLayoutId = name + "_" + Math.random();
         }
         var _loc1_:HelpLayoutVO = new HelpLayoutVO();
         _loc1_.x = 0;
         _loc1_.y = 0;
         _loc1_.width = this.list.width;
         _loc1_.height = this.bg.height;
         _loc1_.extensibilityDirection = this.helpDirection;
         _loc1_.message = LOBBY_HELP.HANGAR_CREW;
         _loc1_.id = this._helpLayoutId;
         _loc1_.scope = this;
         return new <HelpLayoutVO>[_loc1_];
      }
      
      public function updateSize(param1:Number) : void
      {
         var _loc2_:Boolean = param1 >= MAX_CREW * DEFAULT_RENDERER_HEIGHT;
         var _loc3_:String = !!_loc2_ ? Linkages.CREW_DEFAULT_RENDERER_LINKAGE : Linkages.CREW_SMALL_RENDERER_LINKAGE;
         var _loc4_:Boolean = this.list.itemRendererName != _loc3_;
         if(_loc4_)
         {
            this.list.rowHeight = !!_loc2_ ? Number(DEFAULT_RENDERER_HEIGHT) : Number(SMALL_RENDERER_HEIGHT);
            this.list.itemRendererName = _loc3_;
            this.list.validateNow();
            this.list.invalidateData();
            this.updateDogItemPosition();
         }
      }
      
      private function updateDogItemPosition() : void
      {
         var _loc1_:Number = NaN;
         if(this.list.dataProvider)
         {
            _loc1_ = Boolean(this._crewDogItem) ? Number(this.list.dataProvider.length + 1) : Number(this.list.dataProvider.length);
            this.maskMC.height = this.bg.height = _loc1_ * this.list.rowHeight;
         }
         if(this._crewDogItem)
         {
            this._crewDogItem.x = this.bg.x;
            this._crewDogItem.y = this.bg.y + this.bg.height - this.list.rowHeight;
         }
         setSize(width,this.bg.height);
      }
      
      private function removeDogItem() : void
      {
         if(this._crewDogItem)
         {
            this._crewDogItem.removeEventListener(CrewDogEvent.TO_MORE_INFO_CLICK,this.onCrewDogItemToMoreInfoClickHandler);
            this._crewDogItem.removeEventListener(CrewDogEvent.ON_ITEM_CLICK,this.onCrewDogItemOnItemClickHandler);
            removeChild(this._crewDogItem);
            this._crewDogItem.dispose();
            this._crewDogItem = null;
         }
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         invalidate(INVALIDATE_ENABLE);
      }
      
      private function onCrewDogItemOnItemClickHandler(param1:CrewDogEvent) : void
      {
         onCrewDogItemClickS();
      }
      
      private function onCrewDogItemToMoreInfoClickHandler(param1:CrewDogEvent) : void
      {
         onCrewDogMoreInfoClickS();
      }
      
      private function onStageEquipTankmanHandler(param1:CrewEvent) : void
      {
         var _loc2_:TankmanVO = TankmanVO(param1.initProp);
         equipTankmanS(_loc2_.tankmanID.toString(),_loc2_.currentRole.slot);
      }
      
      private function onStageShowRecruitWindowHandler(param1:CrewEvent) : void
      {
         onShowRecruitWindowClickS(param1.initProp,param1.menuEnabled);
      }
      
      private function onStageOpenPersonalCaseHandler(param1:CrewEvent) : void
      {
         var _loc2_:TankmanRoleVO = TankmanRoleVO(param1.initProp);
         openPersonalCaseS(_loc2_.tankmanID.toString(),param1.selectedTab);
      }
   }
}
