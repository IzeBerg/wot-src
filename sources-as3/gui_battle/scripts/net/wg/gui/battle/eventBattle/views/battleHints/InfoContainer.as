package net.wg.gui.battle.eventBattle.views.battleHints
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.eventBattle.views.battleHints.constants.HINT_LABELS;
   import net.wg.gui.battle.views.battleHint.vo.BattleHintVO;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class InfoContainer extends MovieClip implements IDisposable
   {
       
      
      public var txtMessage:TextContainer = null;
      
      public var icon:Image = null;
      
      private var _disposed:Boolean = false;
      
      public function InfoContainer()
      {
         super();
      }
      
      public function showHint(param1:BattleHintVO) : void
      {
         if(StringUtils.isNotEmpty(param1.iconSource))
         {
            this.icon.source = param1.iconSource;
            this.icon.visible = true;
         }
         else
         {
            this.icon.visible = false;
         }
         this.txtMessage.setText(param1.message);
         gotoAndPlay(HINT_LABELS.SHOW_LABEL);
      }
      
      public function hideHint() : void
      {
         gotoAndPlay(HINT_LABELS.OUT_SHOW_LABEL);
      }
      
      public function closeHint() : void
      {
         gotoAndStop(1);
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.txtMessage.dispose();
         this.txtMessage = null;
         this.icon.dispose();
         this.icon = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
