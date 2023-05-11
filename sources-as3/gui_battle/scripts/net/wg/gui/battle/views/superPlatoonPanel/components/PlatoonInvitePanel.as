package net.wg.gui.battle.views.superPlatoonPanel.components
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.InvitationStatus;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.views.superPlatoonPanel.renderers.PlatoonInviteRenderer;
   import net.wg.utils.IScheduler;
   
   public class PlatoonInvitePanel extends BattleUIComponent
   {
      
      private static const RENDERER_HEIGHT:int = 25;
      
      private static const FIRST_LIST_ELEMENT:int = 0;
      
      private static const DELAYED_INVITE_REMOVAL_LENGTH:int = 500;
       
      
      public var container:MovieClip = null;
      
      private var _platoonInviteRenderers:Vector.<PlatoonInviteRenderer> = null;
      
      private var _scheduler:IScheduler = null;
      
      private var _maxInvites:int = 0;
      
      public function PlatoonInvitePanel()
      {
         super();
         this._scheduler = App.utils.scheduler;
         this._platoonInviteRenderers = new Vector.<PlatoonInviteRenderer>(0);
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.DATA) && this._platoonInviteRenderers.length > 0)
         {
            _loc1_ = this._platoonInviteRenderers.length;
            _loc2_ = 0;
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               this._platoonInviteRenderers[_loc3_].visible = true;
               this._platoonInviteRenderers[_loc3_].y = RENDERER_HEIGHT * _loc2_;
               _loc2_++;
               _loc3_++;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this._scheduler.cancelTask(this.removeInvite);
         this._scheduler = null;
         this.removePlatoonInvites();
         this.container = null;
         super.onDispose();
      }
      
      public function updatePlatoonInvite(param1:Number, param2:DAAPIVehicleInfoVO, param3:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:PlatoonInviteRenderer = null;
         var _loc6_:int = 0;
         if(!param2)
         {
            return;
         }
         this.visible = true;
         if(InvitationStatus.isReceivedInactive(param3))
         {
            _loc4_ = this.getRendererIndexByVehicleID(param2.vehicleID);
            if(_loc4_ > -1 && this._platoonInviteRenderers)
            {
               this._platoonInviteRenderers[_loc4_].visible = false;
               this._scheduler.scheduleTask(this.removeInvite,DELAYED_INVITE_REMOVAL_LENGTH,_loc4_);
            }
         }
         else if(InvitationStatus.isReceived(param3))
         {
            _loc5_ = App.utils.classFactory.getComponent(Linkages.PLAYER_PLATOON_INVITE_UI,PlatoonInviteRenderer);
            if(this._platoonInviteRenderers.length >= this._maxInvites)
            {
               this.removeInvite(FIRST_LIST_ELEMENT);
            }
            _loc6_ = this._platoonInviteRenderers.length;
            _loc5_.setInviteData(param2,true);
            _loc5_.y = RENDERER_HEIGHT * _loc6_;
            _loc5_.addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStageHandler);
            this._platoonInviteRenderers.push(_loc5_);
            this.container.addChild(_loc5_);
            invalidateData();
         }
      }
      
      public function updateVehicleInfo(param1:DAAPIVehicleInfoVO) : void
      {
         var _loc2_:int = this._platoonInviteRenderers.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(this._platoonInviteRenderers[_loc3_].vehicleID == param1.vehicleID)
            {
               this._platoonInviteRenderers[_loc3_].setInviteData(param1,false);
            }
            _loc3_++;
         }
      }
      
      private function getRendererIndexByVehicleID(param1:Number) : int
      {
         var _loc2_:int = this._platoonInviteRenderers.length;
         var _loc3_:int = -1;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            if(this._platoonInviteRenderers[_loc4_].vehicleID == param1)
            {
               _loc3_ = _loc4_;
               break;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      private function removeInvite(param1:int) : void
      {
         if(param1 != -1 && this._platoonInviteRenderers && param1 < this._platoonInviteRenderers.length)
         {
            this._platoonInviteRenderers[param1].removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStageHandler);
            this.container.removeChild(this._platoonInviteRenderers[param1]);
            this._platoonInviteRenderers[param1].dispose();
            this._platoonInviteRenderers.splice(param1,1);
            invalidateData();
         }
      }
      
      private function removePlatoonInvites() : void
      {
         var _loc1_:PlatoonInviteRenderer = null;
         if(this._platoonInviteRenderers)
         {
            for each(_loc1_ in this._platoonInviteRenderers)
            {
               _loc1_.removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStageHandler);
               _loc1_.dispose();
            }
            this._platoonInviteRenderers.splice(0,this._platoonInviteRenderers.length);
            this._platoonInviteRenderers = null;
         }
      }
      
      public function set maxInvites(param1:int) : void
      {
         this._maxInvites = param1;
      }
      
      public function get maxInvites() : int
      {
         return this._maxInvites;
      }
      
      private function onRemovedFromStageHandler(param1:Event) : void
      {
         this.removeInvite(FIRST_LIST_ELEMENT);
      }
   }
}
