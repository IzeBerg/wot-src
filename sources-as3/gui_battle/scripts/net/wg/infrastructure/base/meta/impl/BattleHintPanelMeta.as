package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleDisplayable;
   
   public class BattleHintPanelMeta extends BattleDisplayable
   {
       
      
      public var onPlaySound:Function;
      
      public var onHideComplete:Function;
      
      public function BattleHintPanelMeta()
      {
         super();
      }
      
      public function onPlaySoundS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onPlaySound,"onPlaySound" + Errors.CANT_NULL);
         this.onPlaySound(param1);
      }
      
      public function onHideCompleteS() : void
      {
         App.utils.asserter.assertNotNull(this.onHideComplete,"onHideComplete" + Errors.CANT_NULL);
         this.onHideComplete();
      }
   }
}
