package net.wg.gui.battle.views.prebattleInfo.questInfo
{
   import flash.display.Sprite;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class QuestInfoFlagTaskIcoContainer extends Sprite implements IDisposable
   {
       
      
      public var taskIco:UILoaderAlt = null;
      
      public function QuestInfoFlagTaskIcoContainer()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.taskIco.dispose();
         this.taskIco = null;
      }
      
      public function setData(param1:String) : void
      {
         this.taskIco.source = param1;
      }
   }
}
