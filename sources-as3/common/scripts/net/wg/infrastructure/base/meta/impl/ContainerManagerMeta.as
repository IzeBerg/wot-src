package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.BaseDAAPIModule;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class ContainerManagerMeta extends BaseDAAPIModule
   {
       
      
      public var isModalViewsIsExists:Function;
      
      private var _vectorint:Vector.<int>;
      
      private var _vectorint1:Vector.<int>;
      
      public function ContainerManagerMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._vectorint)
         {
            this._vectorint.splice(0,this._vectorint.length);
            this._vectorint = null;
         }
         if(this._vectorint1)
         {
            this._vectorint1.splice(0,this._vectorint1.length);
            this._vectorint1 = null;
         }
         super.onDispose();
      }
      
      public function isModalViewsIsExistsS() : Boolean
      {
         App.utils.asserter.assertNotNull(this.isModalViewsIsExists,"isModalViewsIsExists" + Errors.CANT_NULL);
         return this.isModalViewsIsExists();
      }
      
      public final function as_showContainers(param1:Array, param2:int) : void
      {
         var _loc3_:Vector.<int> = this._vectorint;
         this._vectorint = new Vector.<int>(0);
         var _loc4_:uint = param1.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            this._vectorint[_loc5_] = param1[_loc5_];
            _loc5_++;
         }
         this.showContainers(this._vectorint,param2);
         if(_loc3_)
         {
            _loc3_.splice(0,_loc3_.length);
         }
      }
      
      public final function as_hideContainers(param1:Array, param2:int) : void
      {
         var _loc3_:Vector.<int> = this._vectorint1;
         this._vectorint1 = new Vector.<int>(0);
         var _loc4_:uint = param1.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            this._vectorint1[_loc5_] = param1[_loc5_];
            _loc5_++;
         }
         this.hideContainers(this._vectorint1,param2);
         if(_loc3_)
         {
            _loc3_.splice(0,_loc3_.length);
         }
      }
      
      protected function showContainers(param1:Vector.<int>, param2:int) : void
      {
         var _loc3_:String = "as_showContainers" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc3_);
         throw new AbstractException(_loc3_);
      }
      
      protected function hideContainers(param1:Vector.<int>, param2:int) : void
      {
         var _loc3_:String = "as_hideContainers" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc3_);
         throw new AbstractException(_loc3_);
      }
   }
}
