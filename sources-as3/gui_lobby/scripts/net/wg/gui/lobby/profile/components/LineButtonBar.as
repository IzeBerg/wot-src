package net.wg.gui.lobby.profile.components
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.advanced.ButtonBarEx;
   
   public class LineButtonBar extends ButtonBarEx
   {
      
      protected static const LINE_INVALID:String = "lineInv";
       
      
      protected var line:Sprite;
      
      public var mcBG:Sprite;
      
      protected var lineColor:int = 6710617;
      
      public function LineButtonBar()
      {
         this.line = new Sprite();
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(this.mcBG)
         {
            this.mcBG.visible = false;
         }
         addChild(this.line);
      }
      
      override public function set selectedIndex(param1:int) : void
      {
         if(param1 == _selectedIndex)
         {
            return;
         }
         super.selectedIndex = param1;
         var _loc2_:DisplayObject = _renderers[_selectedIndex];
         if(_loc2_)
         {
            _loc2_.parent.setChildIndex(_loc2_,_loc2_.parent.numChildren - 1);
         }
         invalidate(LINE_INVALID);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(LINE_INVALID))
         {
            this.drawLine();
         }
      }
      
      protected function drawLine() : void
      {
         var _loc3_:DisplayObject = null;
         var _loc4_:uint = 0;
         var _loc1_:Graphics = this.line.graphics;
         _loc1_.clear();
         if(selectedIndex != -1 && _renderers && _renderers.length > 0)
         {
            _loc1_.lineStyle(1,this.lineColor);
            _loc3_ = _renderers[selectedIndex] as DisplayObject;
            App.utils.asserter.assertNotNull(_loc3_,"selItem" + Errors.CANT_NULL);
            _loc4_ = _loc3_.x;
            _loc1_.moveTo(0,0);
            if(_loc4_ > 0)
            {
               _loc1_.lineTo(_loc4_,0);
            }
            _loc1_.moveTo(_loc4_ + _loc3_.width,0);
            _loc1_.lineTo(width,0);
         }
         this.line.y = this.height - this.line.height - 2;
         var _loc2_:DisplayObjectContainer = this.line.parent;
         if(_loc2_)
         {
            _loc2_.setChildIndex(this.line,_loc2_.numChildren - 1);
         }
      }
      
      override protected function updateRenderers() : void
      {
         super.updateRenderers();
         this.drawLine();
      }
   }
}
