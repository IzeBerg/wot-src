package net.wg.gui.battle.comp7.battleloading
{
   import flash.display.Sprite;
   import net.wg.data.VO.daapi.DAAPIArenaInfoVO;
   import net.wg.gui.battle.battleloading.BattleLoading;
   
   public class Comp7BattleLoading extends BattleLoading
   {
       
      
      public var vignette:Sprite = null;
      
      public function Comp7BattleLoading()
      {
         super();
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         super.updateStage(param1,param2);
         this.vignette.width = param1;
         this.vignette.height = param2;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.vignette.mouseChildren = this.vignette.mouseEnabled = false;
      }
      
      override protected function onDispose() : void
      {
         this.vignette = null;
         super.onDispose();
      }
      
      override protected function updateWinText(param1:DAAPIArenaInfoVO) : void
      {
         form.updateWinText(param1.winTextShort);
      }
   }
}
