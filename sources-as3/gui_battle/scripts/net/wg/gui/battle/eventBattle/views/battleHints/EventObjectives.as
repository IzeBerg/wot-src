package net.wg.gui.battle.eventBattle.views.battleHints
{
   import net.wg.infrastructure.base.meta.IEventObjectivesMeta;
   import net.wg.infrastructure.base.meta.impl.EventObjectivesMeta;
   
   public class EventObjectives extends EventObjectivesMeta implements IEventObjectivesMeta
   {
       
      
      public var txtMessage:TextContainer = null;
      
      public function EventObjectives()
      {
         super();
      }
      
      public function as_updateObjectives(param1:String) : void
      {
         this.visible = true;
         this.txtMessage.setText(param1);
      }
      
      public function as_hide() : void
      {
         this.visible = false;
      }
      
      override protected function onDispose() : void
      {
         this.txtMessage.dispose();
         this.txtMessage = null;
         super.onDispose();
      }
   }
}
