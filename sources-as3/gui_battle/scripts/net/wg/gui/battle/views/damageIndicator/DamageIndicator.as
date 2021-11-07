package net.wg.gui.battle.views.damageIndicator
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class DamageIndicator extends BattleUIComponent
   {
       
      
      public var animationDamageMC:MovieClip = null;
      
      public var animationNoDamageMC:MovieClip = null;
      
      public function DamageIndicator()
      {
         super();
         visible = false;
         this.animationDamageMC.stop();
         this.animationNoDamageMC.stop();
      }
      
      override protected function onDispose() : void
      {
         this.animationDamageMC = null;
         this.animationNoDamageMC = null;
         super.onDispose();
      }
      
      public function hide() : void
      {
         visible = false;
         this.animationDamageMC.stop();
         this.animationNoDamageMC.stop();
      }
      
      public function show(param1:Boolean, param2:Number) : void
      {
         parent.setChildIndex(this,parent.numChildren - 1);
         visible = true;
         this.animationDamageMC.visible = param1;
         this.animationNoDamageMC.visible = !param1;
         (!!param1 ? this.animationDamageMC : this.animationNoDamageMC).gotoAndPlay(param2);
      }
   }
}
