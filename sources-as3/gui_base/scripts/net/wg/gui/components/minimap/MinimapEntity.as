package net.wg.gui.components.minimap
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.minimap.interfaces.IMinimapEntry;
   import net.wg.infrastructure.base.meta.IMinimapEntityMeta;
   import net.wg.infrastructure.base.meta.impl.MinimapEntityMeta;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.constants.ConstrainMode;
   import scaleform.clik.utils.Constraints;
   
   public class MinimapEntity extends MinimapEntityMeta implements IMinimapEntityMeta
   {
       
      
      public var icons:MovieClip;
      
      public var iconsMask:MovieClip;
      
      public function MinimapEntity()
      {
         super();
         constraints = new Constraints(this,ConstrainMode.COUNTER_SCALE);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:DisplayObject = null;
         while(this.icons.numChildren > 0)
         {
            _loc1_ = this.icons.getChildAt(0);
            IDisposable(_loc1_).dispose();
            this.icons.removeChild(_loc1_);
         }
         this.icons = null;
         this.iconsMask = null;
         super.onDispose();
      }
      
      public function as_updatePoints() : void
      {
         var _loc1_:int = this.icons.numChildren;
         var _loc2_:IMinimapEntry = null;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = this.icons.getChildAt(_loc3_) as IMinimapEntry;
            App.utils.asserter.assertNotNull(_loc2_,"minimapEntry" + Errors.CANT_NULL);
            if(_loc2_.isTeamPoint())
            {
               _loc2_.update(null);
            }
            _loc3_++;
         }
      }
   }
}
