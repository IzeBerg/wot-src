package net.wg.gui.lobby.techtree.controls
{
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.SoundButtonEx;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class BlueprintsModeSwitchButton extends SoundButtonEx
   {
      
      private static const ANIMATED_STATES_DEFAULT:Vector.<String> = Vector.<String>(["animated_",""]);
      
      private static const ANIMATED_STATES_SELECTED:Vector.<String> = Vector.<String>(["animated_selected_",""]);
       
      
      public var states:MovieClip;
      
      private var _selectedStateChanged:Boolean = false;
      
      public function BlueprintsModeSwitchButton()
      {
         super();
         toggle = true;
         mouseEnabledOnDisabled = true;
      }
      
      override public function canPlaySound(param1:String) : Boolean
      {
         return false;
      }
      
      override protected function draw() : void
      {
         if(_baseDisposed)
         {
            return;
         }
         if(isInvalid(InvalidationType.STATE))
         {
            this._selectedStateChanged = false;
            if(this.states != null && StringUtils.isNotEmpty(_newFrame))
            {
               App.utils.asserter.assert(_labelHash.hasOwnProperty(_newFrame),"Not found state " + _newFrame);
               this.states.gotoAndPlay(_newFrame);
               if(_baseDisposed)
               {
                  return;
               }
            }
         }
         super.draw();
      }
      
      override protected function getStatePrefixes() : Vector.<String>
      {
         if(this._selectedStateChanged)
         {
            return !!_selected ? ANIMATED_STATES_SELECTED : ANIMATED_STATES_DEFAULT;
         }
         return super.getStatePrefixes();
      }
      
      override public function set selected(param1:Boolean) : void
      {
         if(_selected != param1)
         {
            this._selectedStateChanged = true;
         }
         super.selected = param1;
      }
   }
}
