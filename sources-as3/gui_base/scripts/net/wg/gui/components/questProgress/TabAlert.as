package net.wg.gui.components.questProgress
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.data.constants.generated.QUESTSPROGRESS;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class TabAlert extends Sprite implements IDisposable
   {
      
      private static const DESCRIPTION_GAP:int = 4;
       
      
      public var icon:QuestProgressAtlasSprite = null;
      
      public var alertTf:TextField = null;
      
      public var descrTf:TextField = null;
      
      public function TabAlert()
      {
         super();
         this.icon.isCentralize = true;
         this.icon.imageName = QUESTSPROGRESS.WARNING;
         this.alertTf.text = QUESTS.BATTLEPROGRESS_ALERTLABEL_TITLE;
         App.utils.commons.updateTextFieldSize(this.alertTf,true,false);
         this.descrTf.x = this.alertTf.x + this.alertTf.width + DESCRIPTION_GAP;
      }
      
      public final function dispose() : void
      {
         this.icon = null;
         this.alertTf = null;
         this.descrTf = null;
      }
      
      public function setDescription(param1:String, param2:int = 0) : void
      {
         if(param1)
         {
            this.descrTf.text = param1;
            if(param2)
            {
               this.descrTf.width = param2 - this.descrTf.x;
               App.utils.commons.updateTextFieldSize(this.descrTf,false,true);
            }
            else
            {
               App.utils.commons.updateTextFieldSize(this.descrTf,true,false);
            }
         }
         this.descrTf.visible = Boolean(param1);
      }
   }
}
