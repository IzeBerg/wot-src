package net.wg.gui.lobby.epicBattles.components.skillView
{
   import flash.display.MovieClip;
   import net.wg.gui.components.tooltips.inblocks.data.BlockDataItemVO;
   import net.wg.gui.lobby.epicBattles.data.EpicBattleSkillVO;
   import net.wg.gui.lobby.epicBattles.events.EpicBattlesSkillViewClickEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class SkillInfoPane extends UIComponentEx
   {
      
      public static const INFO_WIDTH_MINRES:int = 344;
      
      public static const INFO_WIDTH_REGULAR:int = 400;
       
      
      public var infoPaneContent:SkillInfoPaneContent = null;
      
      public var infoPaneBg:MovieClip = null;
      
      private var _voData:EpicBattleSkillVO = null;
      
      public function SkillInfoPane()
      {
         super();
      }
      
      override public function setSize(param1:Number, param2:Number) : void
      {
         super.setSize(param1,param2);
         this.infoPaneContent.invalidateSize();
      }
      
      override protected function onDispose() : void
      {
         this.infoPaneContent.removeEventListener(EpicBattlesSkillViewClickEvent.SKILL_LEVEL_UP_CLICKED,this.onSkillLevelUpClickedHandler);
         this.infoPaneContent.dispose();
         this.infoPaneContent = null;
         this.infoPaneBg = null;
         if(this._voData)
         {
            this._voData.dispose();
            this._voData = null;
         }
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.infoPaneBg.width = _width;
            this.infoPaneBg.height = _height;
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.infoPaneContent.addEventListener(EpicBattlesSkillViewClickEvent.SKILL_LEVEL_UP_CLICKED,this.onSkillLevelUpClickedHandler);
      }
      
      public function setSkillData(param1:BlockDataItemVO) : void
      {
         this.infoPaneContent.setBlockData(param1);
      }
      
      public function setSkillInfo(param1:EpicBattleSkillVO, param2:int) : void
      {
         this._voData = param1;
         this.infoPaneContent.setSkillInfo(param1,param2);
      }
      
      private function onSkillLevelUpClickedHandler(param1:EpicBattlesSkillViewClickEvent) : void
      {
         this.infoPaneContent.animateSkillLevelUp(this._voData.level + 1);
      }
   }
}
