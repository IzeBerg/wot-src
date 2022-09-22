package net.wg.gui.lobby.personalMissions.components.statusFooter
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.TableRenderer;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.personalMissions.data.TankgirlVO;
   import net.wg.gui.lobby.personalMissions.events.TankgirlRendererEvent;
   import scaleform.clik.events.ButtonEvent;
   
   public class TankgirlsListRenderer extends TableRenderer
   {
       
      
      public var operationTf:TextField = null;
      
      public var missionTf:TextField = null;
      
      public var recruitBtn:ISoundButtonEx = null;
      
      public var icon:UILoaderAlt = null;
      
      private var _id:String;
      
      public function TankgirlsListRenderer()
      {
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         var _loc2_:TankgirlVO = null;
         super.setData(param1);
         if(param1 != null)
         {
            _loc2_ = TankgirlVO(param1);
            this.operationTf.htmlText = _loc2_.operationLabel;
            this.missionTf.htmlText = _loc2_.missionLabel;
            this.recruitBtn.label = _loc2_.recruitBtnLabel;
            this._id = _loc2_.id;
            mouseChildren = true;
         }
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.operationTf = null;
         this.missionTf = null;
         this.recruitBtn.removeEventListener(ButtonEvent.CLICK,this.onRecruitBtnClickHandler);
         this.recruitBtn.dispose();
         this.recruitBtn = null;
         this.icon.dispose();
         this.icon = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         isPassive = true;
         mouseEnabled = false;
         mouseChildren = true;
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.recruitBtn.addEventListener(ButtonEvent.CLICK,this.onRecruitBtnClickHandler);
         this.recruitBtn.label = PERSONAL_MISSIONS.PERSONALMISSIONS_TANKGIRLSPOPOVER_RECRUITBTN;
         this.icon.source = RES_ICONS.MAPS_ICONS_QUESTS_BONUSES_SMALL_TANKWOMAN;
      }
      
      private function onRecruitBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new TankgirlRendererEvent(TankgirlRendererEvent.CLICK,this._id,true));
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.PERSONAL_MISSIONS_TANKWOMAN,null);
      }
   }
}
