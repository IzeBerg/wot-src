package net.wg.gui.battle.views.postMortemTips
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class PostmortemTips extends Sprite implements IDisposable
   {
       
      
      public var bg:BattleAtlasSprite = null;
      
      public var observerModeTitleTF:TextField = null;
      
      public var observerModeDescTF:TextField = null;
      
      public var exitToHangarTitleTF:TextField = null;
      
      public var exitToHangarDescTF:TextField = null;
      
      private var _disposed:Boolean = false;
      
      public function PostmortemTips()
      {
         super();
         this.bg.imageName = BATTLEATLAS.POSTMORTEM_TIPS_BG;
         this.observerModeTitleTF.text = INGAME_GUI.POSTMORTEM_TIPS_OBSERVERMODE_LABEL;
         this.observerModeDescTF.text = INGAME_GUI.POSTMORTEM_TIPS_OBSERVERMODE_TEXT;
         this.exitToHangarTitleTF.text = INGAME_GUI.POSTMORTEM_TIPS_EXITHANGAR_LABEL;
         this.exitToHangarDescTF.text = INGAME_GUI.POSTMORTEM_TIPS_EXITHANGAR_TEXT;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.bg = null;
         this.observerModeTitleTF = null;
         this.observerModeDescTF = null;
         this.exitToHangarTitleTF = null;
         this.exitToHangarDescTF = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
