package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.views.questProgress.QuestProgressView;
   
   public class QuestProgressTopViewMeta extends QuestProgressView
   {
       
      
      public var onPlaySound:Function;
      
      public function QuestProgressTopViewMeta()
      {
         super();
      }
      
      public function onPlaySoundS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onPlaySound,"onPlaySound" + Errors.CANT_NULL);
         this.onPlaySound(param1);
      }
   }
}
