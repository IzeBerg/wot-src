package net.wg.gui.lobby.quests.components
{
   import flash.text.TextField;
   
   public class QuestsProgress extends BaseQuestsProgress
   {
       
      
      public var ltTf:TextField = null;
      
      public var mtTf:TextField = null;
      
      public var htTf:TextField = null;
      
      public var ptTf:TextField = null;
      
      public var sauTf:TextField = null;
      
      public function QuestsProgress()
      {
         super();
         addFields(this.ltTf,this.mtTf,this.htTf,this.ptTf,this.sauTf);
      }
      
      override protected function onDispose() : void
      {
         this.ltTf = null;
         this.mtTf = null;
         this.htTf = null;
         this.ptTf = null;
         this.sauTf = null;
         super.onDispose();
      }
   }
}
