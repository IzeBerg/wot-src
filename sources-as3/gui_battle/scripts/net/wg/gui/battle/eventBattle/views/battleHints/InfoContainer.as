package net.wg.gui.battle.eventBattle.views.battleHints
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.eventBattle.views.battleHints.data.HintInfoVO;
   import net.wg.gui.bootcamp.battleTopHint.constants.HINT_LABELS;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class InfoContainer extends MovieClip implements IDisposable
   {
      
      private static const DEFAULT_COLOR:uint = 16777215;
       
      
      public var txtMessage:TextContainer = null;
      
      public var icon:Image = null;
      
      public function InfoContainer()
      {
         super();
      }
      
      public function showHint(param1:String, param2:HintInfoVO) : void
      {
         if(StringUtils.isNotEmpty(param2.iconSource))
         {
            this.icon.source = param2.iconSource;
            this.icon.visible = true;
         }
         else
         {
            this.icon.visible = false;
         }
         this.txtMessage.setText(param2.message,DEFAULT_COLOR);
         gotoAndPlay(HINT_LABELS.SHOW_LABEL);
      }
      
      public function hideHint() : void
      {
         gotoAndPlay(HINT_LABELS.OUT_SHOW_LABEL);
      }
      
      public function dispose() : void
      {
         this.txtMessage.dispose();
         this.txtMessage = null;
         this.icon.dispose();
         this.icon = null;
      }
      
      public function setWidth(param1:Number) : void
      {
         this.txtMessage.setWidth(param1);
      }
   }
}
