package 
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;

    dynamic public class Scroller extends MovieClip
    {
        public var contents_mc:MovieClip;
        public var scroller_mc:MovieClip;
        public var SlideTrack:MovieClip;
        public var NumberItems:Number;
        public var scrollUpper:Number;
        public var scrollLower:Number;
        public var scrollHeight:Number;
        public var contentsLower:Number;
        public var contentsUpper:Number;
        public var scrollRange:Number;
        public var contentsRange:Number;
        public var App:MovieClip;

        public function bbScroller()
        {
            return;
        }

        public function init(App)
        {
            NumberItems = 100;
            scrollUpper = 100;
            scrollLower = 380;
            scrollHeight = scrollLower - scrollUpper;
            scrollRange = scrollLower - scrollUpper;
            contentsLower = 65;
            contentsUpper = 200 - NumberItems * 150 / 4;
            contentsRange = contentsLower - contentsUpper;
            if (App.AppSettings.Buttons.RollOver == true)
            {
                scroller_mc.addEventListener(MouseEvent.ROLL_OVER, App.ButtonRollOver);
                scroller_mc.addEventListener(MouseEvent.ROLL_OUT, App.ButtonRollOut);
            }
            scroller_mc.addEventListener(MouseEvent.MOUSE_DOWN, Press_Scroller);
            App.loadArt(App.AppSettings.AppUI.VideoInfo.Elements.Scroller.Background, scroller_mc.BG, "MenuArt");
            App.loadArt(App.AppSettings.AppUI.VideoInfo.Elements.ScrollTrack.Background, SlideTrack.BG, "MenuArt");
            stage.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel_VideoInfo);
            return;
        }

        public function mouseWheel_VideoInfo(param1)
        {
            trace("test");
            trace("The delta value is: " + param1.delta);
            mouseScroll(param1.delta);
            return;
        }

        public function mouseScroll(delta)
        {
           if (scroller_mc.visible == true) {   
                var moveMe = scroller_mc.y - (delta * (10));
                
                if (moveMe < scrollUpper) {
                    moveMe = scrollUpper;       
                }
                
                if (moveMe > scrollLower) {
                    moveMe = scrollLower;       
                }
                
                scroller_mc.y = moveMe;
                
                var moved = scroller_mc.y - scrollUpper;
                var pctMoved = moved/scrollRange;
                var contentsMoved = pctMoved*contentsRange;
                contents_mc.y = contentsLower - contentsMoved;  
            }
            return;
        }

        public function scroll(event:MouseEvent)
        {
            var moved = scroller_mc.y - scrollUpper;    
            var pctMoved = moved/scrollRange;
            var contentsMoved = pctMoved*contentsRange;
            contents_mc.y = contentsLower - contentsMoved;
            return;
        }

        public function scroll2()
        {
            var moved = scroller_mc.y - scrollUpper;
            var pctMoved = moved/scrollRange;
            var contentsMoved = pctMoved*contentsRange;
            contents_mc.y = contentsLower - contentsMoved;
            return;
        }

        public function Press_Scroller(event:MouseEvent)
        {
            var bounds = new Rectangle(scroller_mc.x,scrollUpper,0,scrollHeight);
            trace("startDrag: " + scroller_mc.x + " " + scrollUpper + " " + scrollHeight);
            scroller_mc.startDrag(false, bounds);
            stage.addEventListener(MouseEvent.MOUSE_MOVE, scroll);
            scroller_mc.removeEventListener(MouseEvent.MOUSE_DOWN, Press_Scroller);
            stage.addEventListener(MouseEvent.MOUSE_UP, Release_Scroller);
            return;
        }

        public function Release_Scroller(event:MouseEvent)
        {
            var object = event.target;
            trace("stopDrag: " + scroller_mc.x);
            scroller_mc.stopDrag();
            stage.removeEventListener(MouseEvent.MOUSE_MOVE, scroll);
            scroller_mc.addEventListener(MouseEvent.MOUSE_DOWN, Press_Scroller);
            stage.removeEventListener(MouseEvent.MOUSE_UP, Release_Scroller);
            return;
        }

        public function doDown(event:MouseEvent) : void
        {
            addEventListener(Event.ENTER_FRAME, doEnter);
            return;
        }

        public function doEnter(event:Event) : void
        {
            Click_DownArrow();
            return;
        }

        public function doUp(event:MouseEvent) : void
        {
            removeEventListener(Event.ENTER_FRAME, doEnter);
            return;
        }

        public function doDown2(event:MouseEvent) : void
        {
            addEventListener(Event.ENTER_FRAME, doEnter2);
            return;
        }

        public function doEnter2(event:Event) : void
        {
            Click_UpArrow();
            return;
        }

        public function doUp2(event:MouseEvent) : void
        {
            removeEventListener(Event.ENTER_FRAME, doEnter2);
            return;
        }

        public function Click_UpArrow()
        {
            if (scroller_mc.y > scrollUpper)
            {
                scroller_mc.y = scroller_mc.y - 5;
                if (scroller_mc.y < scrollUpper)
                {
                    scroller_mc.y = scrollUpper;
                }
                scroll2();
            }
            return;
        }

        public function Click_DownArrow()
        {
            if (scroller_mc.y < scrollLower)
            {
                scroller_mc.y = scroller_mc.y + 5;
                if (scroller_mc.y > scrollLower)
                {
                    scroller_mc.y = scrollLower;
                }
                scroll2();
            }
            return;
        }

    }
}
