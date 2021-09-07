package net.wg.gui.components.carousels
{
   import flash.display.DisplayObjectContainer;
   import net.wg.data.managers.IToolTipParams;
   import net.wg.data.managers.ITooltipProps;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.managers.ITooltipFormatter;
   import net.wg.infrastructure.managers.ITooltipMgr;
   
   public class TooltipDecorator implements ITooltipMgr, IDisposable
   {
       
      
      private var _mgr:ITooltipMgr = null;
      
      private var _enabled:Boolean = true;
      
      private var _postponedFunction:Function = null;
      
      private var _postponedArgs:Array = null;
      
      public function TooltipDecorator()
      {
         super();
         this._mgr = App.toolTipMgr;
      }
      
      public function dispose() : void
      {
         this._mgr = null;
         this._postponedFunction = null;
         this._postponedArgs = null;
      }
      
      public function getContainer() : DisplayObjectContainer
      {
         return this._mgr.getContainer();
      }
      
      public function getDefaultTooltipProps() : ITooltipProps
      {
         return this._mgr.getDefaultTooltipProps();
      }
      
      public function getNewFormatter() : ITooltipFormatter
      {
         return this._mgr.getNewFormatter();
      }
      
      public function hide() : void
      {
         this._mgr.hide();
         if(!this._enabled)
         {
            this._postponedFunction = null;
            this._postponedArgs = null;
         }
      }
      
      public function show(param1:String, param2:ITooltipProps = null) : void
      {
         if(this._enabled)
         {
            this._mgr.show(param1,param2);
         }
         else
         {
            this._postponedFunction = this._mgr.show;
            this._postponedArgs = [param1,param2];
         }
      }
      
      public function showComplex(param1:String, param2:ITooltipProps = null) : void
      {
         if(this._enabled)
         {
            this._mgr.showComplex(param1,param2);
         }
         else
         {
            this._postponedFunction = this._mgr.showComplex;
            this._postponedArgs = [param1,param2];
         }
      }
      
      public function showComplexWithParams(param1:String, param2:IToolTipParams, param3:ITooltipProps = null) : void
      {
         if(this._enabled)
         {
            this._mgr.showComplexWithParams(param1,param2,param3);
         }
         else
         {
            this._postponedFunction = this._mgr.showComplexWithParams;
            this._postponedArgs = [param1,param2,param3];
         }
      }
      
      public function showLocal(param1:String, param2:Object, param3:ITooltipProps = null) : void
      {
         if(this._enabled)
         {
            this._mgr.showLocal(param1,param2,param3);
         }
         else
         {
            this._postponedFunction = this._mgr.showLocal;
            this._postponedArgs = [param1,param2,param3];
         }
      }
      
      public function showSpecial(param1:String, param2:ITooltipProps, ... rest) : void
      {
         rest.unshift(param1,param2);
         if(this._enabled)
         {
            this._mgr.showSpecial.apply(this._mgr,rest);
         }
         else
         {
            this._postponedFunction = this._mgr.showSpecial;
            this._postponedArgs = rest;
         }
      }
      
      public function showWulfTooltip(param1:String, ... rest) : void
      {
         rest.unshift(param1);
         if(this._enabled)
         {
            this._mgr.showWulfTooltip.apply(this._mgr,rest);
         }
         else
         {
            this._postponedFunction = this._mgr.showWulfTooltip;
            this._postponedArgs = rest;
         }
      }
      
      public function get enabled() : Boolean
      {
         return this._enabled;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         if(this._enabled != param1)
         {
            this._enabled = param1;
            if(this._enabled)
            {
               if(this._postponedFunction != null)
               {
                  this._postponedFunction.apply(this._mgr,this._postponedArgs);
               }
            }
            else
            {
               this._postponedFunction = null;
               this._postponedArgs = null;
            }
         }
      }
   }
}
