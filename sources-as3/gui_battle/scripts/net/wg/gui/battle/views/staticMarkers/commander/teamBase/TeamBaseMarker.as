package net.wg.gui.battle.views.staticMarkers.commander.teamBase
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class TeamBaseMarker extends Sprite implements IDisposable
   {
      
      private static const _ACTIVE_VALUES:Object = {
         "state":"selected",
         "iconScale":0.75,
         "alpha":1,
         "textYOffset":50
      };
      
      private static const _INACTIVE_VALUES:Object = {
         "state":"unselected",
         "iconScale":0.7,
         "alpha":0.75,
         "textYOffset":50
      };
       
      
      public const markerType:String = "base";
      
      public var marker:TeamBaseIcon = null;
      
      public var arrow:MovieClip = null;
      
      public var txtLabel:TextField = null;
      
      private var _alphaVal:Number = 1;
      
      private var _isDisposed:Boolean = false;
      
      public function TeamBaseMarker()
      {
         super();
         this.marker.visible = true;
         this.marker.targetHighlight.visible = false;
         this.arrow.visible = false;
         this.txtLabel.visible = true;
      }
      
      public final function dispose() : void
      {
         this.marker.dispose();
         this.marker = null;
         this.arrow = null;
         this.txtLabel = null;
         this._isDisposed = true;
      }
      
      public final function isDisposed() : Boolean
      {
         return this._isDisposed;
      }
      
      public function notifyVehicleInCircle(param1:Boolean) : void
      {
         this.alpha = !!param1 ? Number(0) : Number(this._alphaVal);
      }
      
      public function setCapturePoints(param1:String, param2:Number) : void
      {
         this.marker.setCapturePoints(param1,param2);
      }
      
      public function setActive(param1:Boolean) : void
      {
         var _loc2_:Object = null;
         _loc2_ = !!param1 ? _ACTIVE_VALUES : _INACTIVE_VALUES;
         this.arrow.gotoAndStop(_loc2_["state"]);
         this.marker.setInternalIconScale(_loc2_["iconScale"]);
         this.marker.targetHighlight.visible = param1;
         alpha = this._alphaVal = _loc2_["alpha"];
         this.txtLabel.y = _loc2_["textYOffset"];
         this.txtLabel.visible = param1;
      }
      
      public function setIdentifier(param1:Number) : void
      {
         this.marker.setBaseId(param1);
      }
      
      public function setState(param1:String) : void
      {
         this.marker.setState(param1);
      }
   }
}
