package net.wg.gui.battle.historicalBattles.battleHints
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.components.animatedBattleHint.constants.HINT_LABELS;
   import net.wg.gui.battle.historicalBattles.battleHints.data.HintInfoVO;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class InfoContainer extends MovieClip implements IDisposable
   {
      
      private static const DEFAULT_COLOR:uint = 16777215;
       
      
      public var txtMessage:TextContainer = null;
      
      public var icon:Image = null;
      
      private var _disposed:Boolean = false;
      
      private var _colorMgr:IColorSchemeManager;
      
      public function InfoContainer()
      {
         this._colorMgr = App.colorSchemeMgr;
         super();
      }
      
      public function showHint(param1:HintInfoVO) : void
      {
         if(this._colorMgr.getIsColorBlindS() && StringUtils.isNotEmpty(param1.iconSourceBlind))
         {
            this.icon.source = param1.iconSourceBlind;
            this.icon.visible = true;
         }
         else if(StringUtils.isNotEmpty(param1.iconSource))
         {
            this.icon.source = param1.iconSource;
            this.icon.visible = true;
         }
         else
         {
            this.icon.visible = false;
         }
         this.txtMessage.setText(param1.message,DEFAULT_COLOR);
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
      
      public function dispose() : void
      {
         this._disposed = true;
         this._colorMgr = null;
         this.txtMessage.dispose();
         this.txtMessage = null;
         this.icon.dispose();
         this.icon = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function setWidth(param1:Number) : void
      {
         this.txtMessage.setWidth(param1);
      }
   }
}
