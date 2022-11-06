package net.wg.gui.battle.random.views.stats.components.playersPanel.list
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class InviteReceivedIndicator extends Sprite implements IDisposable
   {
       
      
      public var inviteTF:TextField;
      
      public var inviteIcon:BattleAtlasSprite;
      
      private var _disposed:Boolean = false;
      
      public function InviteReceivedIndicator()
      {
         super();
         this.inviteTF.text = INGAME_GUI.DYNAMICSQUAD_INVITE;
         this.inviteIcon.imageName = BATTLEATLAS.SQUAD_INVITE_RECEIVED;
         App.utils.commons.updateTextFieldSize(this.inviteTF,true,false);
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.inviteTF = null;
         this.inviteIcon = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
