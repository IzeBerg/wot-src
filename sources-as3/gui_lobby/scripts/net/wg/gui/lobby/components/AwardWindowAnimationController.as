package net.wg.gui.lobby.components
{
   import net.wg.gui.lobby.components.interfaces.IAwardWindowAnimationController;
   import net.wg.gui.lobby.components.interfaces.IAwardWindowAnimationWrapper;
   
   public class AwardWindowAnimationController implements IAwardWindowAnimationController
   {
      
      private static var _instance:AwardWindowAnimationController;
       
      
      private var _lastActiveAnimation:IAwardWindowAnimationWrapper;
      
      private var _disposed:Boolean = false;
      
      public function AwardWindowAnimationController()
      {
         super();
      }
      
      public static function get instance() : AwardWindowAnimationController
      {
         if(_instance == null)
         {
            _instance = new AwardWindowAnimationController();
         }
         return _instance;
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this._lastActiveAnimation = null;
      }
      
      public function registerAnimation(param1:IAwardWindowAnimationWrapper) : void
      {
         if(this._lastActiveAnimation != param1)
         {
            if(this._lastActiveAnimation != null)
            {
               this._lastActiveAnimation.disableAnimation();
            }
            this._lastActiveAnimation = param1;
         }
      }
      
      public function unregisterAnimation(param1:IAwardWindowAnimationWrapper) : void
      {
         if(this._lastActiveAnimation == param1)
         {
            this._lastActiveAnimation = null;
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
