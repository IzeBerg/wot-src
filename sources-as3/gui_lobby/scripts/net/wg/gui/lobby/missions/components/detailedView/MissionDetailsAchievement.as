package net.wg.gui.lobby.missions.components.detailedView
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.missions.data.MissionDetailsAchievementRendererVO;
   import scaleform.clik.constants.InvalidationType;
   
   public class MissionDetailsAchievement extends SoundListItemRenderer
   {
      
      private static const DOTS:String = "...";
       
      
      public var loader:UILoaderAlt;
      
      public var labelTf:TextField;
      
      private var _vo:MissionDetailsAchievementRendererVO;
      
      public function MissionDetailsAchievement()
      {
         super();
         this.loader.hideLoader = false;
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         this._vo = MissionDetailsAchievementRendererVO(param1);
         invalidateData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.loader.mouseChildren = false;
         this.loader.buttonMode = false;
         buttonMode = false;
      }
      
      override protected function onDispose() : void
      {
         if(this.loader)
         {
            this.loader.dispose();
            this.loader = null;
         }
         this.labelTf = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._vo && isInvalid(InvalidationType.DATA))
         {
            this.loader.source = this._vo.icon;
            App.utils.commons.truncateHtmlTextMultiline(this.labelTf,this._vo.label,1,DOTS);
         }
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void
      {
         super.handleMouseRollOut(param1);
         App.toolTipMgr.hide();
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         super.handleMouseRollOver(param1);
         App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.BATTLE_STATS_ACHIEVS,null,this._vo.block,this._vo.type);
      }
   }
}
