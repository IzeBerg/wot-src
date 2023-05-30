package net.wg.gui.battle.battleRoyale.views.components.respawnMessages
{
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   
   public class RespawnMessageTimer extends BaseRespawnMessage
   {
       
      
      public var tfTime:TextField = null;
      
      public var tfLabel:TextField = null;
      
      public var tfDescription:TextField = null;
      
      public function RespawnMessageTimer()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.tfTime = null;
         this.tfLabel = null;
         this.tfDescription = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.updateTimeTF();
            this.tfLabel.text = data.title;
            this.tfDescription.text = data.description;
         }
      }
      
      private function updateTimeTF() : void
      {
         var _loc1_:String = curTime.toString();
         this.tfTime.text = curTime > 9 ? _loc1_ : "0" + _loc1_;
      }
   }
}
