package net.wg.gui.battle.views.epicRespawnView.components
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.interfaces.entity.ISoundable;
   import net.wg.infrastructure.managers.ISoundManager;
   
   public class EpicRespawnPoint extends MovieClip implements IDisposable, ISoundable
   {
      
      private static const NORMAL_STATE_LABEL:String = "normal";
      
      private static const HOVERED_STATE_LABEL:String = "hovered";
      
      private static const SELECTED_STATE_LABEL:String = "selected";
      
      private static const HOVER_ANIM_LABEL:String = "hover";
      
      private static const SELECT_ANIM_LABEL:String = "select";
      
      private static const UNSELECT_ANIM_LABEL:String = "unselect";
      
      private static const OUT_ANIM_LABEL:String = "out";
      
      private static const WARNING_TEXT_ALPHA_NORMAL:Number = 0;
      
      private static const WARNING_TEXT_ALPHA_HOVER:Number = 1;
       
      
      public var warningIcon:DisplayObject;
      
      public var warningText:TextField;
      
      private var _hovered:Boolean = false;
      
      private var _selected:Boolean = false;
      
      private var _showWarning:Boolean = false;
      
      private var _baseDisposed:Boolean = false;
      
      private var _soundMgr:ISoundManager;
      
      public function EpicRespawnPoint()
      {
         this._soundMgr = App.soundMgr;
         super();
         this.buttonMode = true;
         this.mouseChildren = false;
         this._soundMgr.addSoundsHdlrs(this);
         this.warningIcon.visible = this.warningText.visible = this._showWarning;
         this.warningText.text = EPIC_BATTLE.DEPLOYMENTMAP_RESPAWNWARNING;
         this.warningText.alpha = WARNING_TEXT_ALPHA_NORMAL;
         this.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         this.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
      }
      
      protected function onDispose() : void
      {
         this.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         this.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this._soundMgr.removeSoundHdlrs(this);
         this._soundMgr = null;
         this.warningIcon = null;
         this.warningText = null;
      }
      
      public final function dispose() : void
      {
         if(this._baseDisposed)
         {
            return;
         }
         this.onDispose();
         this._baseDisposed = true;
      }
      
      public function get selected() : Boolean
      {
         return this._selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(param1 == this._selected)
         {
            return;
         }
         this._selected = param1;
         this.buttonMode = !this._selected;
         if(this._selected == this._hovered)
         {
            if(this._selected)
            {
               gotoAndPlay(SELECT_ANIM_LABEL);
            }
            else
            {
               gotoAndPlay(UNSELECT_ANIM_LABEL);
            }
         }
         else
         {
            this.forceState();
         }
      }
      
      public function setSelectedState(param1:Boolean) : void
      {
         if(param1 == this._selected)
         {
            return;
         }
         this._selected = param1;
         this.buttonMode = !this._selected;
         this.forceState();
      }
      
      public function get showWarning() : Boolean
      {
         return this._showWarning;
      }
      
      public function set showWarning(param1:Boolean) : void
      {
         if(param1 == this._showWarning)
         {
            return;
         }
         this._showWarning = param1;
         this.warningIcon.visible = this.warningText.visible = this._showWarning;
      }
      
      public function canPlaySound(param1:String) : Boolean
      {
         return !this._selected;
      }
      
      public function getSoundType() : String
      {
         return !!this._showWarning ? SoundTypes.EPIC_RESPAWN_POINT_WARNING : SoundTypes.EPIC_RESPAWN_POINT_NORMAL;
      }
      
      public function getSoundId() : String
      {
         return Values.EMPTY_STR;
      }
      
      private function forceState() : void
      {
         if(this._selected)
         {
            gotoAndStop(SELECTED_STATE_LABEL);
         }
         else if(this._hovered)
         {
            gotoAndStop(HOVERED_STATE_LABEL);
         }
         else
         {
            gotoAndStop(NORMAL_STATE_LABEL);
         }
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         this._hovered = true;
         this.warningText.alpha = WARNING_TEXT_ALPHA_HOVER;
         this.parent.addChild(this);
         if(!this._selected)
         {
            gotoAndPlay(HOVER_ANIM_LABEL);
         }
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         this._hovered = false;
         this.warningText.alpha = WARNING_TEXT_ALPHA_NORMAL;
         if(!this._selected)
         {
            gotoAndPlay(OUT_ANIM_LABEL);
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._baseDisposed;
      }
   }
}
