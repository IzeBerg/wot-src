package net.wg.gui.battle.battleRoyale.views.components.respawnMessages
{
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   
   public class RespawnMessageWithDescription extends BaseRespawnMessage
   {
       
      
      public var tfTitle:TextField = null;
      
      public var tfDescription:TextField = null;
      
      public function RespawnMessageWithDescription()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.tfTitle = null;
         this.tfDescription = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.tfDescription.text = data.description;
            this.tfTitle.text = data.title;
         }
      }
   }
}
